# Kaip Deploy į External Tomcat

$env:CATALINA_HOME = "C:\apache-tomcat-10.1.33"
$env:JAVA_HOME = "C:\Programos\jdk-24.0.2"
C:\apache-tomcat-10.1.33\bin\startup.bat

arba geriau

java -jar target\rest-service-0.0.1-SNAPSHOT.war

## 1. Paruošimas

### Parsisiųsti ir įdiegti Tomcat:
1. Eikite į: https://tomcat.apache.org/download-10.cgi
2. Parsisiųskite **Apache Tomcat 10.1.x** (Core → zip)
3. Išskleiskite į katalogą (pvz., `C:\apache-tomcat-10.1.33`)

## 2. WAR failo paruošimas

WAR failas jau sukurtas:
```
target\rest-service-0.0.1-SNAPSHOT.war.original
```

Šis failas **neturi** embedded Tomcat - jis skirtas External Tomcat serveriui.

## 3. Deployment į Tomcat

### Būdas A: Automatic Deployment (Rekomenduojama)

1. **Pervadinti ir nukopijuoti WAR failą:**
```powershell
Copy-Item "target\rest-service-0.0.1-SNAPSHOT.war.original" "C:\apache-tomcat-10.1.33\webapps\rest-service.war"
```

2. **Paleisti Tomcat serverį:**
```powershell
C:\apache-tomcat-10.1.33\bin\startup.bat
```

3. **Patikrinti deployment:**
- Atidaryti naršyklėje: http://localhost:8080/rest-service/prekes
- Tomcat automatiškai išpakuos WAR failą ir paleisti aplikaciją

### Būdas B: Manager App Deployment

1. **Paleisti Tomcat:**
```powershell
C:\apache-tomcat-10.1.33\bin\startup.bat
```

2. **Konfigūruoti manager vartotoją** (jei dar nesukonfigūravote):
- Redaguoti `C:\apache-tomcat-10.1.33\conf\tomcat-users.xml`
- Pridėti:
```xml
<role rolename="manager-gui"/>
<user username="admin" password="admin" roles="manager-gui"/>
```

3. **Upload per Web UI:**
- Eiti į: http://localhost:8080/manager
- Įvesti: admin / admin
- Sections "Deploy" → "WAR file to deploy"
- Pasirinkti: `target\rest-service-0.0.1-SNAPSHOT.war.original`
- Spausti "Deploy"

## 4. Patikrinti aplikaciją

Po deployment, aplikacija bus prieinama adresu:
- **Home:** http://localhost:8080/rest-service/
- **Prekių sąrašas:** http://localhost:8080/rest-service/prekes

## 5. Tomcat valdymas

### Paleisti Tomcat:
```powershell
C:\apache-tomcat-10.1.33\bin\startup.bat
```

### Sustabdyti Tomcat:
```powershell
C:\apache-tomcat-10.1.33\bin\shutdown.bat
```

### Peržiūrėti logus:
```powershell
Get-Content "C:\apache-tomcat-10.1.33\logs\catalina.out" -Tail 50 -Wait
```

## 6. Konfiguracija

### Context Path keitimas:
Jei norite keisti URL (`/rest-service` → `/prekes`):
1. Pervadinti WAR failą į `prekes.war`
2. Arba sukurti `META-INF/context.xml`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<Context path="/prekes" />
```

### Root context (`/`):
Pervadinti WAR failą į `ROOT.war`:
```powershell
Copy-Item "target\rest-service-0.0.1-SNAPSHOT.war.original" "C:\apache-tomcat-10.1.33\webapps\ROOT.war"
```

## 7. Duomenų bazės konfigūracija

Aplikacija prisijungs prie MySQL:
- **Duomenų bazė:** PrekeLD2_db
- **Username:** root
- **Password:** (jūsų MySQL root slaptažodis)

Įsitikinkite, kad:
1. MySQL serveris veikia
2. PrekeLD2_db duomenų bazė egzistuoja
3. PrekeLD2 lentelė yra sukurta su duomenimis

## 8. Troubleshooting

### Aplikacija nepaleidžiama:
- Peržiūrėti: `C:\apache-tomcat-10.1.33\logs\catalina.out`
- Patikrinti: `C:\apache-tomcat-10.1.33\logs\localhost.log`

### Port konfliktas:
Jei 8080 portas užimtas, pakeisti Tomcat portą:
- Redaguoti: `C:\apache-tomcat-10.1.33\conf\server.xml`
- Rasti `<Connector port="8080"...`
- Pakeisti į `port="9090"` ar kitą laisvą portą

### MySQL connection klaidos:
- Patikrinti ar MySQL serveris veikia
- Patikrinti `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/PrekeLD2_db
spring.datasource.username=root
spring.datasource.password=your_password
```

## 9. Skirtumas tarp Embedded ir External Tomcat

### Embedded Tomcat (Spring Boot default):
- ✅ Paleidžiama: `./mvnw.cmd spring-boot:run`
- ✅ Vienas JAR/WAR failas su viskuo
- ✅ Lengva development
- ❌ Sunkiau skalė multiple aplikacijas

### External Tomcat:
- ✅ Galima deploy daug aplikacijų viename serveryje
- ✅ Centralizuotas Tomcat valdymas
- ✅ Production aplinka
- ✅ Galima naudoti Tomcat Manager UI
- ❌ Reikia atskirai įdiegti Tomcat

## 10. Production Tips

1. **Pakeisti application.properties production režimui:**
```properties
spring.jpa.show-sql=false
spring.jpa.hibernate.ddl-auto=validate
logging.level.root=WARN
```

2. **Sukurti atskirą MySQL vartotoją:**
```sql
CREATE USER 'preke_user'@'localhost' IDENTIFIED BY 'strong_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON PrekeLD2_db.* TO 'preke_user'@'localhost';
```

3. **Konfigūruoti Tomcat memory:**
```powershell
set CATALINA_OPTS=-Xms512M -Xmx1024M -XX:MaxPermSize=256M
```
