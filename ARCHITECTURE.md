# Projekto Architektūra ir Technologijos

## 1. Projekto Struktūra

### Backend Architektūra (MVC Pattern)

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                    │
│  ┌──────────────────────────────────────────────────┐   │
│  │         JSP Views (list.jsp, form.jsp, view.jsp) │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────┬───────────────────────────────────────┘
                  │
┌─────────────────▼───────────────────────────────────────┐
│                    Controller Layer                      │
│  ┌──────────────────────────────────────────────────┐   │
│  │    StudentController (Spring MVC @Controller)    │   │
│  │    - Handles HTTP requests                       │   │
│  │    - Returns view names                          │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────┬───────────────────────────────────────┘
                  │
┌─────────────────▼───────────────────────────────────────┐
│                     Service Layer                        │
│  ┌──────────────────────────────────────────────────┐   │
│  │      StudentService (Business Logic)             │   │
│  │      - CRUD operations                           │   │
│  │      - Data validation                           │   │
│  │      - Transaction management                    │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────┬───────────────────────────────────────┘
                  │
┌─────────────────▼───────────────────────────────────────┐
│                   Repository Layer                       │
│  ┌──────────────────────────────────────────────────┐   │
│  │   StudentRepository (Spring Data JPA)            │   │
│  │   - Database access                              │   │
│  │   - Query methods                                │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────┬───────────────────────────────────────┘
                  │
┌─────────────────▼───────────────────────────────────────┐
│                      Data Layer                          │
│  ┌──────────────────────────────────────────────────┐   │
│  │         Hibernate (JPA Implementation)           │   │
│  │         MySQL Database (studentdb)               │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

## 2. Technologijos ir Versijos

### Backend Technologijos
| Technologija | Versija | Paskirtis |
|--------------|---------|-----------|
| Java | 21 | Programavimo kalba |
| Spring Boot | 3.5.7 | Framework pagrindas |
| Spring MVC | 6.x | Web framework |
| Spring Data JPA | 3.x | Duomenų prieiga |
| Hibernate | 6.x | ORM (Object-Relational Mapping) |
| MySQL Connector | 8.x | JDBC driver |

### Frontend Technologijos
| Technologija | Paskirtis |
|--------------|-----------|
| JSP | Server-side rendering |
| JSTL | JSP tagų biblioteka |
| HTML5 | Markup |
| CSS3 | Stilizavimas |
| JavaScript | Kliento pusės logika |

### Build & Deploy
| Technologija | Versija | Paskirtis |
|--------------|---------|-----------|
| Maven | 3.9.11 | Build tool |
| Apache Tomcat | 10.1.x | Application server |

## 3. Hibernate Konfigūracija

### Entity Mapping
```java
@Entity
@Table(name = "students")
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "first_name", nullable = false, length = 50)
    private String firstName;
    
    // ... kiti laukai
}
```

### JPA Properties
```properties
# Hibernate DDL
spring.jpa.hibernate.ddl-auto=update

# SQL Logging
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# Dialect
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQLDialect
```

### Hibernate DDL Strategijos
- **update**: Automatiškai atnaujina schemą (development)
- **validate**: Tik patikrina schemą (production)
- **create**: Sukuria naują schemą (testing)
- **create-drop**: Sukuria ir išmeta schemą (testing)

## 4. Spring MVC Flow

### Request Processing Flow
```
1. Client Request → http://localhost:8080/students
                    ↓
2. DispatcherServlet (Front Controller)
                    ↓
3. HandlerMapping → Finds StudentController
                    ↓
4. StudentController.listStudents()
                    ↓
5. StudentService.getAllStudents()
                    ↓
6. StudentRepository.findAll()
                    ↓
7. Hibernate/JPA → SQL Query
                    ↓
8. MySQL Database → Returns data
                    ↓
9. Data mapped to Student entities
                    ↓
10. Model populated with data
                    ↓
11. ViewResolver → Resolves "students/list" to list.jsp
                    ↓
12. JSP rendered with data
                    ↓
13. HTML Response → Client
```

## 5. CRUD Operácie - Detali Implementacija

### CREATE Operation
**Flow**: Form → Controller → Service → Repository → Database

```java
// 1. GET /students/new - Rodo formą
@GetMapping("/new")
public String showNewStudentForm(Model model) {
    model.addAttribute("student", new Student());
    return "students/form";
}

// 2. POST /students/save - Išsaugo studentą
@PostMapping("/save")
public String saveStudent(@ModelAttribute("student") Student student) {
    studentService.saveStudent(student);
    return "redirect:/students";
}
```

### READ Operations
**Flow**: Request → Controller → Service → Repository → Database → View

```java
// Visi studentai
@GetMapping("")
public String listStudents(Model model) {
    List<Student> students = studentService.getAllStudents();
    model.addAttribute("students", students);
    return "students/list";
}

// Vienas studentas
@GetMapping("/view/{id}")
public String viewStudent(@PathVariable Long id, Model model) {
    Student student = studentService.getStudentById(id);
    model.addAttribute("student", student);
    return "students/view";
}
```

### UPDATE Operation
**Flow**: Edit Form → Controller → Service → Repository → Database

```java
// 1. GET /students/edit/{id} - Rodo redagavimo formą
@GetMapping("/edit/{id}")
public String showEditStudentForm(@PathVariable Long id, Model model) {
    Student student = studentService.getStudentById(id);
    model.addAttribute("student", student);
    return "students/form";
}

// 2. POST /students/update/{id} - Atnaujina studentą
@PostMapping("/update/{id}")
public String updateStudent(@PathVariable Long id, 
                          @ModelAttribute Student student) {
    studentService.updateStudent(id, student);
    return "redirect:/students";
}
```

### DELETE Operation
**Flow**: Delete Link → Controller → Service → Repository → Database

```java
@GetMapping("/delete/{id}")
public String deleteStudent(@PathVariable Long id) {
    studentService.deleteStudent(id);
    return "redirect:/students";
}
```

## 6. Duomenų Bazės Schema

### Students Lentelė
```sql
CREATE TABLE students (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    birth_date DATE,
    course VARCHAR(100),
    year INT,
    INDEX idx_last_name (last_name),
    INDEX idx_email (email),
    INDEX idx_course (course),
    INDEX idx_year (year)
) ENGINE=InnoDB;
```

### SQL Queries Generated by Hibernate

**SELECT (findAll)**:
```sql
SELECT s.id, s.first_name, s.last_name, s.email, 
       s.birth_date, s.course, s.year
FROM students s;
```

**INSERT**:
```sql
INSERT INTO students 
(first_name, last_name, email, birth_date, course, year) 
VALUES (?, ?, ?, ?, ?, ?);
```

**UPDATE**:
```sql
UPDATE students 
SET first_name=?, last_name=?, email=?, 
    birth_date=?, course=?, year=? 
WHERE id=?;
```

**DELETE**:
```sql
DELETE FROM students WHERE id=?;
```

## 7. Transaction Management

### @Transactional Annotation
```java
@Service
@Transactional  // Klasės lygio
public class StudentService {
    
    @Transactional(readOnly = true)  // Optimizuota skaitymo operacija
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }
    
    @Transactional  // Rašymo operacija
    public Student saveStudent(Student student) {
        return studentRepository.save(student);
    }
}
```

## 8. Deployment Strategijos

### 1. Embedded Tomcat (Development)
```bash
mvnw spring-boot:run
```
- Greitas paleidimas
- Tinka kūrimui
- Nereikia išorinio Tomcat

### 2. External Tomcat (Production)
```bash
mvnw clean package
# Sukuria: target/rest-service-0.0.1-SNAPSHOT.war
```
- Diegiama į išorinį Tomcat
- Geresnė kontrolė
- Tinkamas produkcijai

### 3. Docker Container (Modern)
```dockerfile
FROM tomcat:10.1-jdk21
COPY target/*.war /usr/local/tomcat/webapps/students.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
```

## 9. Security Considerations (Būsimi Patobulinimai)

### Potencialūs Patobulinimai:
- **Spring Security** - Autentifikacija ir autorizacija
- **Password Encryption** - BCrypt hashing
- **CSRF Protection** - Cross-Site Request Forgery apsauga
- **SQL Injection Prevention** - JPA/Hibernate automatiškai apsaugo
- **XSS Prevention** - Input validation ir output encoding

## 10. Performance Optimization

### Database Indexing
```sql
CREATE INDEX idx_last_name ON students(last_name);
CREATE INDEX idx_course ON students(course);
```

### JPA Query Optimization
```java
// N+1 Problem Solution
@EntityGraph(attributePaths = {"course"})
List<Student> findAll();
```

### Connection Pooling
```properties
spring.datasource.hikari.maximum-pool-size=10
spring.datasource.hikari.minimum-idle=5
spring.datasource.hikari.connection-timeout=20000
```

## 11. Testing Strategy

### Unit Tests
```java
@Test
public void testSaveStudent() {
    Student student = new Student("Jonas", "Jonaitis", 
                                  "jonas@test.com", ...);
    Student saved = studentService.saveStudent(student);
    assertNotNull(saved.getId());
}
```

### Integration Tests
```java
@SpringBootTest
@AutoConfigureMockMvc
public class StudentControllerTest {
    @Test
    public void testListStudents() throws Exception {
        mockMvc.perform(get("/students"))
               .andExpect(status().isOk())
               .andExpect(view().name("students/list"));
    }
}
```

## 12. Monitoring & Logging

### Application Logs
```properties
# Logging Level
logging.level.com.example.rest_service=DEBUG
logging.level.org.hibernate.SQL=DEBUG
```

### Tomcat Access Logs
```xml
<Valve className="org.apache.catalina.valves.AccessLogValve"
       directory="logs"
       pattern="%h %l %u %t &quot;%r&quot; %s %b" />
```

## Išvada

Šis projektas demonstruoja pilną **Enterprise Java Web Application** su:
- ✅ **Spring MVC** - Model-View-Controller pattern
- ✅ **Hibernate/JPA** - Object-Relational Mapping
- ✅ **MySQL** - Relational database
- ✅ **CRUD Operations** - Create, Read, Update, Delete
- ✅ **Apache Tomcat** - Application server
- ✅ **JSP/JSTL** - View layer
- ✅ **Maven** - Build automation
- ✅ **Transaction Management** - ACID compliance
