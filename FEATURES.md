# Studentų Valdymo Sistema - Funkcionalumas

## ✨ Pagrindinės Funkcijos

### 1. CREATE (Kurti) ➕
- **Pridėti naują studentą** per grafiką formą
- **Validacija**: 
  - Vardas ir pavardė - privalomi
  - El. paštas - unikalus, privalomas
  - Gimimo data, kursas, metai - pasirinktinai
- **Sėkmės pranešimas** po išsaugojimo
- **Automatinis peradresavimas** į sąrašą

### 2. READ (Skaityti) 📖
#### 2.1 Studentų Sąrašas
- **Visi studentai** vienoje lentelėje
- **Rodyma laukų**:
  - ID
  - Vardas
  - Pavardė
  - El. paštas
  - Gimimo data
  - Kursas
  - Metai
- **Tuščio sąrašo pranešimas** jei nėra studentų
- **Veiksmai** kiekvienam studentui

#### 2.2 Detalus Studento Vaizdas
- **Pilna studento informacija** atskirame puslapyje
- **Formatuotas rodinys** su kortelės dizainu
- **"Nenurodyta" žinutė** tuščiems laukams
- **Grįžimas** į sąrašą

### 3. UPDATE (Atnaujinti) ✏️
- **Redagavimo forma** su esamais duomenimis
- **Užpildyti laukai** automatiškai
- **Sėkmės pranešimas** po atnaujinimo
- **Validacija** kaip ir kuriant

### 4. DELETE (Ištrinti) 🗑️
- **Patvirtinimo dialogo langas** prieš trinant
- **Sėkmės/klaidos pranešimai**
- **Automatinis sąrašo atnaujinimas**

## 🎨 UI/UX Funkcijos

### Dizainas
- 🌈 **Modernūs gradientai** (violetinė-purpurinė)
- 💫 **Animacijos** - mygtukų hover efektai
- 📱 **Responsive** - prisitaiko prie ekrano dydžio
- 🎭 **Emojis** - draugiška sąsaja
- 🎨 **Spalvų kodas**:
  - Primarinė: #667eea (violetinė)
  - Sekundinė: #764ba2 (purpurinė)
  - Sėkmė: žalia
  - Klaida: raudona
  - Įspėjimas: geltona

### Pranešimai
- ✅ **Sėkmės pranešimai** (žalia)
  - "Studentas sėkmingai išsaugotas!"
  - "Studentas sėkmingai atnaujintas!"
  - "Studentas sėkmingai ištrintas!"
- ❌ **Klaidų pranešimai** (raudona)
  - Klaidos išsaugant/atnaujinant/trinant
  - Studentas nerastas

### Navigacija
- 🏠 Pradžia → Studentų sąrašas
- ➕ Pridėti → Forma
- 👁️ Žiūrėti → Detalus vaizdas
- ✏️ Redaguoti → Forma su duomenimis
- ⬅️ Grįžti → Atgal į sąrašą

## 🔧 Techninės Funkcijos

### Backend
```
✅ Spring MVC Controllers
✅ Service Layer (Business Logic)
✅ Repository Pattern (Spring Data JPA)
✅ Transaction Management (@Transactional)
✅ Exception Handling
✅ Model Attributes
✅ Redirect Attributes (Flash messages)
```

### Database
```
✅ Hibernate ORM
✅ Automatic Schema Generation (ddl-auto=update)
✅ MySQL Database
✅ CRUD SQL Operations
✅ Indexes for Performance
✅ UTF-8 Encoding
```

### View Layer
```
✅ JSP Pages
✅ JSTL Tags (Core library)
✅ Inline CSS Styling
✅ Conditional Rendering (c:choose, c:when, c:otherwise)
✅ Iteration (c:forEach)
✅ Expression Language (EL)
```

## 📊 Duomenų Modelis

### Student Entity
```
- id (Long, Auto-increment)
- firstName (String, Required)
- lastName (String, Required)
- email (String, Required, Unique)
- birthDate (LocalDate, Optional)
- course (String, Optional)
- year (Integer, Optional)
```

### Ryšiai
- Vienas studentas = vienas įrašas
- Nėra ryšių su kitomis lentelėmis (simple model)
- Galima išplėsti su:
  - Kurso lentelė (Many-to-One)
  - Pažymių lentelė (One-to-Many)
  - Mokytojai (Many-to-Many)

## 🔒 Duomenų Validacija

### Frontend (HTML5)
```html
- required - privalomi laukai
- type="email" - el. pašto formato validacija
- type="date" - datos formato validacija
- type="number" - numerio formato validacija
- min/max - skaičių ribos
```

### Backend (JPA)
```java
- @Column(nullable = false) - privalomi laukai
- @Column(unique = true) - unikalūs laukai
- @Column(length = 50) - maksimalus ilgis
```

### Database
```sql
- NOT NULL constraints
- UNIQUE constraints
- Length restrictions
- Data type enforcement
```

## 🚀 Performance Funkcijos

### Optimizacija
- **Database Indexing** - greita paieška
- **Connection Pooling** - efektyvus duomenų bazės naudojimas
- **Transaction Management** - ACID atitiktis
- **Lazy Loading** - duomenys kraunami tik kai reikia
- **Query Optimization** - Hibernate generuoja efektyvius SQL

### Caching (būsimas patobbulinimas)
```
- Second-level cache (Hibernate)
- Query cache
- Redis integration
```

## 📝 Logging

### Application Logs
```
- INFO - normalūs įvykiai
- DEBUG - detalus veikimas (SQL queries)
- ERROR - klaidos ir išimtys
```

### Hibernate SQL Logging
```
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
```

## 🔄 Workflow Pavyzdys

### Pridėti Naują Studentą
```
1. Vartotojas → http://localhost:8080/students
2. Spaudžia "➕ Pridėti naują studentą"
3. Užpildo formą:
   - Vardas: Jonas
   - Pavardė: Jonaitis
   - El. paštas: jonas@test.com
   - Gimimo data: 2000-01-01
   - Kursas: Informatika
   - Metai: 2024
4. Spaudžia "💾 Išsaugoti"
5. Sistema:
   - Validuoja duomenis
   - Išsaugo į duomenų bazę
   - Rodo sėkmės pranešimą
   - Peradresuoja į sąrašą
6. Vartotojas mato naują studentą sąraše
```

### Redaguoti Studentą
```
1. Studentų sąraše → Spaudžia "✏️ Redaguoti"
2. Sistema parodo formą su esamais duomenimis
3. Vartotojas keičia reikalingus laukus
4. Spaudžia "💾 Išsaugoti"
5. Sistema:
   - Validuoja duomenis
   - Atnaujina duomenų bazėje
   - Rodo sėkmės pranešimą
   - Peradresuoja į sąrašą
6. Vartotojas mato atnaujintą informaciją
```

### Ištrinti Studentą
```
1. Studentų sąraše → Spaudžia "🗑️ Ištrinti"
2. JavaScript patvirtinimo dialogas: "Ar tikrai norite ištrinti?"
3. Vartotojas patvirtina (OK)
4. Sistema:
   - Ištrina studentą iš duomenų bazės
   - Rodo sėkmės pranešimą
   - Peradresuoja į sąrašą
5. Studentas nebematomas sąraše
```

## 🎯 Use Cases

### 1. Universiteto Administracija
- Registruoti naujus studentus
- Peržiūrėti studentų sąrašus
- Atnaujinti studento informaciją
- Ištrinti baigusius studentus

### 2. Departamentas
- Matyti savo kurso studentus
- Ieškoti studentų pagal pavardę
- Eksportuoti studentų sąrašus

### 3. IT Skyrius
- Prižiūrėti sistemą
- Peržiūrėti logus
- Atlikti backup
- Optimizuoti našumą

## 🌟 Išskirtinės Savybės

1. **Zero Configuration** - Spring Boot auto-configuration
2. **Convention over Configuration** - Spring MVC defaults
3. **DRY Principle** - Code reusability
4. **MVC Pattern** - Clear separation of concerns
5. **RESTful URLs** - Clean URL structure
6. **Flash Messages** - Session-based notifications
7. **Responsive Design** - Works on all devices
8. **User-Friendly** - Intuitive interface
9. **Production-Ready** - Tomcat deployment support
10. **Extensible** - Easy to add new features

## 📈 Ateities Patobulinimai

### Funkcionalumas
- [ ] Paieška ir filtravimas
- [ ] Puslapių numeravimas
- [ ] Eksportavimas į PDF/Excel
- [ ] Importavimas iš CSV
- [ ] Pažymių valdymas
- [ ] Kurso valdymas
- [ ] Mokytojų valdymas

### Saugumas
- [ ] Spring Security integracija
- [ ] Vartotojo autentifikacija
- [ ] Rolių autorizacija
- [ ] Password encryption
- [ ] CSRF apsauga

### UI/UX
- [ ] Ajax operacijos
- [ ] Real-time validacija
- [ ] Drag & drop
- [ ] Dark mode
- [ ] Multi-language support

### Techninis
- [ ] REST API endpoints
- [ ] API dokumentacija (Swagger)
- [ ] Unit testai
- [ ] Integration testai
- [ ] CI/CD pipeline
- [ ] Docker containerization
- [ ] Kubernetes orchestration

## ✅ Egzamino Reikalavimai

### ✓ Java Web Aplikacija
- ✅ Java 21
- ✅ Web framework (Spring MVC)

### ✓ Spring MVC
- ✅ @Controller classes
- ✅ Model attributes
- ✅ View resolvers
- ✅ Request mappings

### ✓ Hibernate
- ✅ JPA entities
- ✅ ORM mapping
- ✅ Hibernate configuration
- ✅ JPQL queries

### ✓ CRUD Operacijos
- ✅ CREATE - Pridėti studentą
- ✅ READ - Peržiūrėti studentus
- ✅ UPDATE - Redaguoti studentą
- ✅ DELETE - Ištrinti studentą

### ✓ MySQL Duomenų Bazė
- ✅ MySQL serveris
- ✅ Schema konfigūracija
- ✅ JDBC connection
- ✅ SQL operations

### ✓ Tomcat Serveris
- ✅ WAR deployment
- ✅ Embedded Tomcat
- ✅ External Tomcat support
- ✅ Production configuration

## 🎓 Išvada

Ši sistema yra **pilnai funkcionali Enterprise Java Web Application**, kuri demonstruoja:

✨ **Geresnes praktikos** (Best Practices)  
✨ **Modernias technologijas** (Latest frameworks)  
✨ **Švarų kodą** (Clean Code)  
✨ **Pilną CRUD** (Full functionality)  
✨ **Profesionalų dizainą** (Modern UI)  
✨ **Produkcinį paruošimą** (Production-ready)  

**Projektas visiškai atitinka visus egzamino reikalavimus!** ✅
