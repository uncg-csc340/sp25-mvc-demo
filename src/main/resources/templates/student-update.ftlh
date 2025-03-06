<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <title>Student List</title>

    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>

<body>

<!-- Begin Nav Bar -->
<nav class="navbar navbar-expand-lg  navbar-dark" style="background-color: #799351;">
    <a class="navbar-brand" href="/students/all" style="margin: 10px;">
        <img src="/images/logo.jpg" alt="" width="80" height="60">
    </a>
    <ul class="nav justify-content-end">
        <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="/students/all">Home</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Second</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Third</a>
        </li>
    </ul>
</nav>

<div class="container" style="margin-top: 15px;">
    <h1>${title}</h1>
    <form id="new-student" action="/students/update/${student.studentId?c}" method="post">
        <input type="text" id="studentId" name="studentId" value="${student.studentId?c}" readonly/>
        <input type="text" id="name" name="name" value="${student.name}" placeholder="Name"/>
        <input type="text" id="major" name="major"  value="${student.major}" placeholder="Major"/>
        <input type="number" id="gpa" name="gpa" step="0.01" value="${student.gpa}" placeholder="GPA"/>
        <button type="submit" class="btn btn-primary">Save</button>
        <button type="reset" class="btn btn-danger" onclick="closeForm()">Cancel</button>
    </form>

</div>
<script>
    function closeForm() {
      document.getElementById("new-student").style.display = "none";
    }
</script>
</body>
</html>
