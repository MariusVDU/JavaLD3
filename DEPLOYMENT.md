# Diegimo į Tomcat Serverį Instrukcijos

## 1. Paruošimas

### 1.1 Atsisiųsti Apache Tomcat
1. Eikite į: https://tomcat.apache.org/download-10.cgi
2. Atsisiųskite **Tomcat 10.1.x** (Core - Binary Distributions)
   - Windows: `apache-tomcat-10.1.x-windows-x64.zip`
   - Linux: `apache-tomcat-10.1.x.tar.gz`

### 1.2 Įdiegti Tomcat
**Windows:**
```powershell
# Išpakuoti į C:\apache-tomcat-10.1
Expand-Archive -Path apache-tomcat-10.1.x-windows-x64.zip -DestinationPath C:\

# Pridėti CATALINA_HOME aplinkos kintamąjį
[System.Environment]::SetEnvironmentVariable("CATALINA_HOME", "C:\apache-tomcat-10.1", "Machine")
```

**Linux/Mac:**
```bash
# Išpakuoti
sudo tar -xvf apache-tomcat-10.1.x.tar.gz -C /opt/
sudo mv /opt/apache-tomcat-10.1.x /opt/tomcat

# Suteikti vykdymo teises
sudo chmod +x /opt/tomcat/bin/*.sh
```

## 2. MySQL Duomenų Bazės Konfigūracija

### 2.1 Įdiegti MySQL
**Windows:**
- Atsisiųsti iš: https://dev.mysql.com/downloads/installer/
- Įdiegti MySQL Community Server

**Linux:**
```bash
sudo apt update
sudo apt install mysql-server
sudo systemctl start mysql
sudo systemctl enable mysql
```

### 2.2 Sukurti duomenų bazę
```bash
# Prisijungti prie MySQL
mysql -u root -p

# Arba importuoti SQL skriptą
mysql -u root -p < database-schema.sql
```

Arba naudokite SQL komandas:
```sql
CREATE DATABASE studentdb;
USE studentdb;
-- Lentelė bus sukurta automatiškai per Hibernate
```

## 3. Projekto Kompiliavimas

### 3.1 Patikrinti Maven
```bash
./mvnw.cmd --version  # Windows
./mvnw --version      # Linux/Mac
```

### 3.2 Sukompiliuoti projektą
```bash
# Windows PowerShell
./mvnw.cmd clean package -DskipTests

# Linux/Mac
./mvnw clean package -DskipTests
```

Rezultatas: `target/rest-service-0.0.1-SNAPSHOT.war`

## 4. Diegimas į Tomcat

### Metodas 1: Automatinis Diegimas (Hot Deploy)

**Windows:**
```powershell
# Nukopijuoti WAR failą
Copy-Item target\rest-service-0.0.1-SNAPSHOT.war C:\apache-tomcat-10.1\webapps\students.war

# Paleisti Tomcat
cd C:\apache-tomcat-10.1\bin
.\startup.bat
```

**Linux/Mac:**
```bash
# Nukopijuoti WAR failą
sudo cp target/rest-service-0.0.1-SNAPSHOT.war /opt/tomcat/webapps/students.war

# Paleisti Tomcat
sudo /opt/tomcat/bin/startup.sh
```

### Metodas 2: Per Tomcat Manager

1. **Įjungti Tomcat Manager:**

Redaguoti `$CATALINA_HOME/conf/tomcat-users.xml`:
```xml
<tomcat-users>
  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <user username="admin" password="admin123" roles="manager-gui,manager-script"/>
</tomcat-users>
```

2. **Atidaryti Tomcat Manager:**
   - URL: http://localhost:8080/manager/html
   - Vartotojas: admin
   - Slaptažodis: admin123

3. **Deploy WAR failą:**
   - Eiti į "WAR file to deploy" sekciją
   - Pasirinkti `rest-service-0.0.1-SNAPSHOT.war`
   - Spauskite "Deploy"

### Metodas 3: Naudojant Maven Plugin

Pridėti į `pom.xml`:
```xml
<plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.2</version>
    <configuration>
        <url>http://localhost:8080/manager/text</url>
        <server>TomcatServer</server>
        <path>/students</path>
    </configuration>
</plugin>
```

Deploy komanda:
```bash
./mvnw.cmd tomcat7:deploy
```

## 5. Patikrinti Diegimą

### 5.1 Patikrinti Tomcat būseną
```bash
# Windows
netstat -ano | findstr :8080

# Linux/Mac
netstat -tuln | grep 8080
```

### 5.2 Peržiūrėti Tomcat logus
**Windows:**
```powershell
Get-Content C:\apache-tomcat-10.1\logs\catalina.out -Wait
```

**Linux/Mac:**
```bash
tail -f /opt/tomcat/logs/catalina.out
```

### 5.3 Atidaryti aplikaciją
- Pagrindinis: http://localhost:8080/students/
- Studentų sąrašas: http://localhost:8080/students/students

## 6. Konfigūracija Produkcijai

### 6.1 Pakeisti duomenų bazės nustatymus
Redaguoti `src/main/resources/application.properties`:
```properties
# Produkcijos nustatymai
spring.datasource.url=jdbc:mysql://production-server:3306/studentdb
spring.datasource.username=production_user
spring.datasource.password=strong_password

# Hibernate - nekeisti duomenų bazės struktūros
spring.jpa.hibernate.ddl-auto=validate

# Išjungti SQL logavimą
spring.jpa.show-sql=false
```

### 6.2 Konfigūruoti Tomcat našumui
Redaguoti `$CATALINA_HOME/conf/server.xml`:
```xml
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           maxThreads="200"
           minSpareThreads="10"
           enableLookups="false"
           acceptCount="100"
           URIEncoding="UTF-8"/>
```

### 6.3 Konfigūruoti JVM atmintį
**Windows** - Redaguoti `bin/catalina.bat`:
```batch
set JAVA_OPTS=-Xms512m -Xmx1024m -XX:MaxPermSize=256m
```

**Linux/Mac** - Redaguoti `bin/catalina.sh`:
```bash
JAVA_OPTS="-Xms512m -Xmx1024m -XX:MaxPermSize=256m"
```

## 7. Problemų Sprendimas

### 7.1 Port jau naudojamas
```bash
# Pakeisti portą server.xml
# Arba išjungti procesą:

# Windows
netstat -ano | findstr :8080
taskkill /PID <PID> /F

# Linux/Mac
lsof -i :8080
kill -9 <PID>
```

### 7.2 Permisijos klaidos (Linux)
```bash
sudo chown -R tomcat:tomcat /opt/tomcat
sudo chmod -R 755 /opt/tomcat
```

### 7.3 MySQL prisijungimo klaida
```sql
-- Sukurti naują vartotoją
CREATE USER 'studentapp'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON studentdb.* TO 'studentapp'@'localhost';
FLUSH PRIVILEGES;
```

### 7.4 JSP kompiliavimo klaida
- Įsitikinti, kad Tomcat versija yra 10.1+
- Patikrinti, kad yra `tomcat-embed-jasper` priklausomybė

## 8. Valdymas

### Paleisti Tomcat:
```bash
# Windows
C:\apache-tomcat-10.1\bin\startup.bat

# Linux/Mac
sudo /opt/tomcat/bin/startup.sh
```

### Sustabdyti Tomcat:
```bash
# Windows
C:\apache-tomcat-10.1\bin\shutdown.bat

# Linux/Mac
sudo /opt/tomcat/bin/shutdown.sh
```

### Peržiūrėti aktyvias aplikacijas:
http://localhost:8080/manager/html

## 9. Saugumo Rekomendacijos

1. **Pakeisti Tomcat Manager slaptažodį**
2. **Naudoti HTTPS (SSL/TLS)**
3. **Apriboti prieigą prie Manager aplikacijos**
4. **Reguliariai atnaujinti Tomcat ir Java**
5. **Naudoti stiprius duomenų bazės slaptažodžius**
6. **Įjungti firewall**

## 10. Automatinis Paleidimas

### Windows Service:
```bash
# Įdiegti kaip Windows servisą
C:\apache-tomcat-10.1\bin\service.bat install

# Paleisti servisą
net start Tomcat10
```

### Linux Systemd:
```bash
# Sukurti servisą
sudo nano /etc/systemd/system/tomcat.service

# Turinys:
[Unit]
Description=Apache Tomcat
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64"
Environment="CATALINA_HOME=/opt/tomcat"
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target

# Įjungti servisą
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat
```

## Išvada
Po šių žingsnių jūsų aplikacija turėtų būti sėkmingai įdiegta ir veikianti Tomcat serveryje!
