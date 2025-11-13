# 📚 Dokumentacijos Indeksas

## Sveiki atvykę į Studentų Valdymo Sistemą!

Ši sistema yra pilnai funkcionali Java web aplikacija, demonstruojanti CRUD operacijas su MySQL duomenų baze, naudojant Spring MVC ir Hibernate technologijas.

---

## 📖 Dokumentacijos Struktūra

### 🚀 Pradžia

#### 1. [README.md](README.md) - PIRMIAUSIA SKAITYKITE ČIA
**Pagrindinė dokumentacija**
- Projekto apžvalga
- Technologijos ir versijos
- Diegimo instrukcijos
- Naudojimo pavyzdžiai
- Problemų sprendimas

#### 2. [QUICKSTART.md](QUICKSTART.md) - Greita Pradžia (5 minutės)
**Trumpas vadovas**
- Minimalūs reikalavimai
- 5 žingsniai iki veikiančios aplikacijos
- Greitas testavimas
- Dažniausios problemos

---

### 🔧 Diegimas ir Konfigūracija

#### 3. [DEPLOYMENT.md](DEPLOYMENT.md) - Išsamus Diegimo Vadovas
**Pilnas deployment guide**
- Tomcat diegimas
- MySQL konfigūracija
- WAR failo kūrimas
- Produkcijos nustatymai
- Automatinis paleidimas

#### 4. [database-schema.sql](database-schema.sql) - Duomenų Bazės Schema
**SQL Skriptas**
- CREATE DATABASE
- CREATE TABLE
- Indeksai
- Pavyzdiniai duomenys

---

### 📐 Architektūra ir Dizainas

#### 5. [ARCHITECTURE.md](ARCHITECTURE.md) - Sistemos Architektūra
**Techninė dokumentacija**
- MVC Pattern
- Layered Architecture
- Spring MVC flow
- Hibernate mapping
- Transaction management
- SQL queries

#### 6. [FEATURES.md](FEATURES.md) - Funkcionalumas
**Funkcijų aprašymas**
- CRUD operacijos
- UI/UX funkcijos
- Validacija
- Workflow pavyzdžiai
- Use cases

---

### 🧪 Testavimas

#### 7. [TESTING.md](TESTING.md) - Testavimo Vadovas
**Test cases**
- CREATE testai
- READ testai
- UPDATE testai
- DELETE testai
- Validacijos testai
- Performance testai

---

### 📊 Santrauka

#### 8. [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Projekto Santrauka
**Apžvalga**
- Projekto statistika
- Technologijų sąrašas
- Failų struktūra
- Egzamino reikalavimai
- Kodo metrikos

---

## 🛠️ Pagalbiniai Failai

### Skriptai

#### [run.bat](run.bat) - Paleidimo Skriptas
```bash
# Automatiškai:
# - Patikrina Java
# - Patikrina MySQL
# - Kompiliuoja projektą
# - Paleidžia aplikaciją
```

#### [build.bat](build.bat) - Build Skriptas
```bash
# Sukuria WAR failą diegimui į Tomcat
```

#### [setup-database.bat](setup-database.bat) - DB Setup
```bash
# Automatiškai sukuria duomenų bazę
# ir importuoja schemą
```

### Konfigūracija

#### [students-context.xml](students-context.xml) - Tomcat Context
```xml
<!-- Tomcat DataSource konfigūracija -->
```

#### [pom.xml](pom.xml) - Maven Konfigūracija
```xml
<!-- Projekto priklausomybės ir build -->
```

#### [application.properties](src/main/resources/application.properties)
```properties
# Spring Boot konfigūracija
# MySQL connection
# Hibernate settings
# JSP configuration
```

---

## 📂 Kodo Struktūra

### Backend (Java)

```
src/main/java/com/example/rest_service/
├── RestServiceApplication.java     # Spring Boot main class
├── controller/
│   ├── HomeController.java         # Home page
│   └── StudentController.java      # CRUD controller
├── model/
│   └── Student.java                # JPA Entity
├── repository/
│   └── StudentRepository.java      # Spring Data JPA
└── service/
    └── StudentService.java         # Business logic
```

### Frontend (JSP)

```
src/main/webapp/WEB-INF/views/students/
├── list.jsp                        # Studentų sąrašas
├── form.jsp                        # CREATE/UPDATE forma
└── view.jsp                        # Detalus vaizdas
```

---

## 🎯 Kaip Naudoti Šią Dokumentaciją

### Jei esate naujas vartotojas:
1. **Pradėkite nuo** → [QUICKSTART.md](QUICKSTART.md)
2. **Tada skaitykite** → [README.md](README.md)
3. **Išbandykite** → [TESTING.md](TESTING.md)

### Jei diegiate į produkciją:
1. **Skaitykite** → [DEPLOYMENT.md](DEPLOYMENT.md)
2. **Konfigūruokite** → `application.properties`
3. **Testuokite** → [TESTING.md](TESTING.md)

### Jei norite suprasti architektūrą:
1. **Skaitykite** → [ARCHITECTURE.md](ARCHITECTURE.md)
2. **Žiūrėkite kodą** → `src/main/java/`
3. **Analizuokite** → [FEATURES.md](FEATURES.md)

### Jei ieškote konkrečios informacijos:
- **Technologijos** → [README.md](README.md) + [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)
- **CRUD operacijos** → [FEATURES.md](FEATURES.md) + [TESTING.md](TESTING.md)
- **Duomenų bazė** → [database-schema.sql](database-schema.sql) + [ARCHITECTURE.md](ARCHITECTURE.md)
- **Problemų sprendimas** → [README.md](README.md) + [DEPLOYMENT.md](DEPLOYMENT.md)

---

## 📖 Skaitomi Formatai

### Markdown failai (.md)
Visi dokumentacijos failai yra Markdown formatu ir gali būti skaitomi:
- **GitHub/GitLab** - automatiškai formatuoja
- **VS Code** - su Markdown preview
- **Bet kuriame teksto redaktoriuje** - kaip paprastas tekstas

### Atidarymas VS Code:
```bash
# Atidaryti preview
Ctrl+Shift+V (Windows)
Cmd+Shift+V (Mac)
```

---

## 🔍 Greita Paieška

### Pagal Temą:

| Tema | Failas |
|------|--------|
| Spring MVC | [ARCHITECTURE.md](ARCHITECTURE.md) |
| Hibernate | [ARCHITECTURE.md](ARCHITECTURE.md) |
| CRUD operacijos | [FEATURES.md](FEATURES.md) |
| MySQL schema | [database-schema.sql](database-schema.sql) |
| Tomcat diegimas | [DEPLOYMENT.md](DEPLOYMENT.md) |
| Testavimas | [TESTING.md](TESTING.md) |
| Validacija | [FEATURES.md](FEATURES.md) |
| Konfigūracija | [README.md](README.md) |

### Pagal Veiksmą:

| Veiksmas | Failas |
|----------|--------|
| Paleisti aplikaciją | [QUICKSTART.md](QUICKSTART.md) |
| Sukurti DB | [database-schema.sql](database-schema.sql) |
| Build WAR | [DEPLOYMENT.md](DEPLOYMENT.md) |
| Testuoti CRUD | [TESTING.md](TESTING.md) |
| Konfigūruoti MySQL | [README.md](README.md) |
| Deploy į Tomcat | [DEPLOYMENT.md](DEPLOYMENT.md) |

---

## 💡 Patarimai

### Dokumentacijos Skaitymo Eiliškumas:

#### Pradedantieji:
```
1. QUICKSTART.md    (5 min)
2. README.md        (15 min)
3. TESTING.md       (10 min)
4. FEATURES.md      (10 min)
```

#### Pažengę:
```
1. README.md        (15 min)
2. ARCHITECTURE.md  (20 min)
3. DEPLOYMENT.md    (20 min)
4. Kodo analizė     (30 min)
```

#### Ekspertai:
```
1. PROJECT_SUMMARY.md
2. ARCHITECTURE.md
3. Tiesiogiai į kodą
4. Performance tuning
```

---

## 🎓 Mokymo Medžiaga

### Studentams:
- [README.md](README.md) - Projekto apžvalga
- [ARCHITECTURE.md](ARCHITECTURE.md) - Architektūros studija
- [TESTING.md](TESTING.md) - Praktinis testavimas
- Kodo analizė - Learning by example

### Dėstytojams:
- [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Projekto įvertinimas
- [FEATURES.md](FEATURES.md) - Funkcionalumo patikrinimas
- [TESTING.md](TESTING.md) - Test cases
- Visi source failai - Kodo review

---

## ✅ Dokumentacijos Checklist

### Ar radote visą reikiamą informaciją?

- [ ] Kaip paleisti aplikaciją
- [ ] Kaip sukonfigūruoti MySQL
- [ ] Kaip veikia CRUD operacijos
- [ ] Kaip diegti į Tomcat
- [ ] Kaip testuoti sistemą
- [ ] Kokia projekto architektūra
- [ ] Kokie naudojami technologijos
- [ ] Kur rasti pavyzdžių

### Jei ne, žiūrėkite:
- **Bendri klausimai** → [README.md](README.md)
- **Techniniai klausimai** → [ARCHITECTURE.md](ARCHITECTURE.md)
- **Diegimo klausimai** → [DEPLOYMENT.md](DEPLOYMENT.md)
- **Testavimo klausimai** → [TESTING.md](TESTING.md)

---

## 📞 Pagalba

### Jei kyla problemų:

1. **Patikrinkite dokumentaciją:**
   - README.md → Bendros problemos
   - DEPLOYMENT.md → Diegimo problemos
   - TESTING.md → Funkcionalumo problemos

2. **Peržiūrėkite logus:**
   ```bash
   # Spring Boot logai
   Konsolė arba logs/application.log
   
   # Tomcat logai
   $CATALINA_HOME/logs/catalina.out
   ```

3. **Patikrinkite konfigūraciją:**
   - application.properties
   - MySQL connection
   - Tomcat settings

4. **Debug režimas:**
   ```properties
   logging.level.com.example=DEBUG
   logging.level.org.hibernate.SQL=DEBUG
   ```

---

## 📈 Dokumentacijos Versijos

- **Versija**: 1.0
- **Data**: 2025-11-11
- **Autorius**: Egzamino projektas
- **Statusas**: ✅ Complete

---

## 🎯 Santrauka

### Dokumentacija Apima:
✅ Diegimo instrukcijas  
✅ Architektūros aprašymą  
✅ Funkcionalumo aprašymą  
✅ Testavimo vadovus  
✅ Problemų sprendimą  
✅ Kodo pavyzdžius  
✅ SQL skriptus  
✅ Konfigūracijos failus  

### Dokumentacijos Privalumai:
🌟 **Išsami** - Viską aptarianti  
🌟 **Struktūruota** - Aiški organizacija  
🌟 **Praktinė** - Pavyzdžiai ir instrukcijos  
🌟 **Vizuali** - Diagramos ir lentelės  
🌟 **Prieinama** - Markdown formatas  

---

## 🚀 Pradėkite Čia!

### 3 Žingsniai iki Sėkmės:

1. **Skaitykite** → [QUICKSTART.md](QUICKSTART.md)
2. **Paleidžiate** → `./mvnw.cmd spring-boot:run`
3. **Testuojate** → http://localhost:8080/

**Sėkmės!** 🎓

---

**Pastaba**: Visi failų keliukai yra santykinis nuo projekto šakninio aplanko.
