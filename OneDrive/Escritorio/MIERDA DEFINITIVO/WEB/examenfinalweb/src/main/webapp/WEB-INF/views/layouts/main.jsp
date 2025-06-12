<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title} - Plataforma Académica</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">Plataforma Académica</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <c:if test="${sessionScope.user != null}">
                        <c:choose>
                            <c:when test="${sessionScope.user.role == 'ADMIN'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="/admin/users">Usuarios</a>
                                </li>
                            </c:when>
                            <c:when test="${sessionScope.user.role == 'TEACHER'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="/teacher/subjects">Mis Asignaturas</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/teacher/schedule">Horarios</a>
                                </li>
                            </c:when>
                            <c:when test="${sessionScope.user.role == 'STUDENT'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="/student/subjects">Mis Cursos</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/student/grades">Calificaciones</a>
                                </li>
                            </c:when>
                        </c:choose>
                    </c:if>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${sessionScope.user == null}">
                            <li class="nav-item">
                                <a class="nav-link" href="/login">Iniciar Sesión</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="/profile">Mi Perfil</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/logout">Cerrar Sesión</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <jsp:include page="/WEB-INF/views/partials/messages.jsp" />
        <jsp:doBody/>
    </div>

    <footer class="footer mt-5 py-3 bg-light">
        <div class="container text-center">
            <span class="text-muted">© 2024 Plataforma Académica</span>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/main.js"></script>
</body>
</html> 