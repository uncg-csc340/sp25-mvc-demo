# sp25-mvc-demo
## CRUD MVC App using JPA/Hibernate, MySQL, and FreeMarker.
## Things to note:
- [Dependencies](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/pom.xml#L32) to JPA, MySQL, and Freemarker, in addition to the usual. JPA handles the persistence, MySQL is the database to be used, FreeMarker generates HTML templates.
- [`/src/main/resources/application.properties`](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/resources/application.properties) file  is the configuration for the MySQL database.
- the database name is on the `datasource.url` property between the last `/` and the `?`. In this case the database name is `student-database`.
  - You MUST have the database up and running before running the project! 
    - Start your AMPPS Server.
    - Click on the Home icon to open the localhost server on your browser.
    - Go to Database Tools and open phpMyAdmin to start up the MySQL Dashboard.
    - Ensure the database that you need is available. Either
      - Create a database called `student-database`
      - OR edit `datasource.url` to point to a database that you do have.
  - Verify your username and password is spelled correctly in the properties file.
- [Entity](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/java/com/csc340/mvc_demo/student/Student.java#L5)
  - The Student class is annotated as an `@Entity `. This is used by Hibernate (an implementation of the Jakarta Persistence API) to map class attributes to database tables and SQL types.
  - We also annotated with `@Table` to give Hibernate directions to use this specific table name. This is optional but it helps with naming conventions.
  - Any Entity must have at least one attribute that is annotated as an `@Id`. In our case it's conveniently the `studentId` attribute.
    - We are also using an autogeneration strategy for the ID. This way we are not manually assigning IDs to our students. This is optional.
  - An Entity must have a no-argument constructor.
  - You also need getters and setters for all attributes.
- [Repository](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/java/com/csc340/mvc_demo/student/StudentRepository.java#L12)
  - We are using an extension of the JPA Repository that comes with prebuilt database operations such as select all, select by id, select by any other reference, insert, delete, etc.
  - Annotate it as a `@Repository`.
  - We parametrize this using our object and its ID type.
    - `public interface StudentRepository extends JpaRepository<Student, Integer>` => We want to apply the JPA repository operations on the `Student` type. The `Student` has an ID of type `int`.
  - If we need special database queries that are not the standard ones mentioned above, we can create [a method with a special purpose query](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/java/com/csc340/mvc_demo/student/StudentRepository.java#L20) as shown. This is an interface so no implementation body.
- [Service](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/java/com/csc340/mvc_demo/student/StudentService.java#L12)
  - Annotated as a `@Service`.
  - It is the go-between from controller to database. In here we define what functions we need from the repository. A lot of the functions are default functions that our repository inherits from JPA (save, delete, findAll, findByX), some of them are custom made (getHonorsStudents, getStudentsByName).
  - It asks the repository to perform SQL queries.
  - The Repository class is [`@Autowired`](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/java/com/csc340/mvc_demo/student/StudentService.java#L15). This is for managing the dependency to the repository. Do not use a constructor to make a Repository object, you will get errors.
- [Controller](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/java/com/csc340/mvc_demo/student/StudentController.java#L16)
  - Note this is a `@Controller` and not a `@RestController`. This is the MVC Controller that returns views instead of objects.
  - All the mappings under this controller will start with `/students`.
  - Return view names.
  - Return `"redirect:/link/to/redirect"` - if there is not necessarily a view attached to an action. e.g. going back to list after deleting one item.
  - Model attribute names and objects using `model.addAttribute("studentList", service.getAllStudents());` 
  - The Service class is [`@Autowired`](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/java/com/csc340/mvc_demo/student/StudentController.java#L20). Do not use a constructor, this will not work.
- Views
  - All views live in [`src/main/resources/templates`](https://github.com/uncg-csc340/sp25-mvc-demo/tree/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/resources/templates).
     - These are `.ftlh` files. They are FreeMarker templates. They work exactly like html to build pages, but they are used by the server to append data from the database.
     - You should configure you IntelliJ to associate `.ftlh` files with `html`.
       - Settings -> Editor -> File Types -> HTML -> Add (+) -> *.ftlh -> Apply ->OK.
     - You can also create subfolders in the templates folder. For example if you wanted views for the student to be in one folder you can create a `students` subfolder and put all the student views in there. Then your Controller would have to `return "students/students-list";` 
  - [`student-list.ftlh`](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/resources/templates/student-list.ftlh)
    - [`<#list studentList as student>`](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/resources/templates/student-list.ftlh#L51C8-L51C39) => "Loop through Student list and make a table row for each Student"
    - [`<td>${student.name}</td>`](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/resources/templates/student-list.ftlh#L56C13-L56C37) => "The text content for this this table data element should be whatever the student name is".
  - For any form that sends POST requests with a form body, the input attribute "name" should match the data field.
    - E.g for the student major [`<input type="text" id="major" name="major" placeholder="Major"/>`](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/resources/templates/student-create.ftlh#L39) we use `name="major"` to use the setters to match that field. If you do not include the input name attribute, a null will be insterted for that field.
  - Remember that any view must have a correspoding mapping. Any web page that is displayed MUST have a mapping in a conroller to show the view.
    - If you wanted to have a page that is a standalone form, you must make a mapping in the controller that returns the form page as a view.
    - Our server is running on Port 8080, if you open the web page directly in the browser, it is not served on localhost, it is just a file and will not have data from the database. If you open it from IntelliJ, it is hosted on Port 63342, which also will not connect to our database and server.
    - In this example, the form for creating a new student is its own page, therefore we must have a mapping to show that page.
      - We have a [`@GetMapping`](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/java/com/csc340/mvc_demo/student/StudentController.java#L104) that shows us the form in our controller.
      - Clicking on the Create New Student button will hit this endpoint and return the form as a view.
    - Same with the form for updating a Student. [`@GetMapping`](https://github.com/uncg-csc340/sp25-mvc-demo/blob/03e5c2c8f477329a66891a4649d9df9d12358f7f/src/main/java/com/csc340/mvc_demo/student/StudentController.java#L136) for displaying the form.
      - Clicking on Edit for any student will hit this endpoint and return the form as a view.
      - Note we also use the model here to carry the Student data that we want to update so it will be shown on the form.
    - **PLEASE NOTE: Web Browsers only allow GET and POST requests! So we replace PUT mappings with POST mappings, and the DELETE with a GET!**
    - Saving the updated data calls the corresponding POST mapping.
      - When we get our Student data from a form, we do not need the `@RequestBody` annotation.
      - NB: Saving and Updating in Hibernate uses the same method. If an entity exists it gets updated, else it gets created. You don't need to worry too much about it.
       ```
         @Transactional
         public <S extends T> S save(S entity) {
           if (this.entityInformation.isNew(entity)) {
              this.em.persist(entity);
              return entity;
            } else {
              return this.em.merge(entity);
          }
         }
        ```
- Run the app in IntelliJ, then on the browser go to: `http://localhost:8080/students/all`
