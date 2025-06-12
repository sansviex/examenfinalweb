<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layouts/main.jsp">
    <jsp:param name="title" value="Dashboard Estudiante" />
    <jsp:attribute name="content">
        <div class="row">
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Mis Cursos</h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty subjects}">
                            <p class="text-muted">No estás inscrito en ningún curso.</p>
                        </c:if>
                        <c:forEach items="${subjects}" var="subject">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span>${subject.title}</span>
                                <a href="/student/subjects/${subject.id}" class="btn btn-sm btn-outline-primary">Ver Detalles</a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Próximas Evaluaciones</h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty evaluations}">
                            <p class="text-muted">No hay evaluaciones programadas.</p>
                        </c:if>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Asignatura</th>
                                        <th>Evaluación</th>
                                        <th>Fecha</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${evaluations}" var="evaluation">
                                        <tr>
                                            <td>${evaluation.subject.title}</td>
                                            <td>${evaluation.title}</td>
                                            <td>${evaluation.date}</td>
                                            <td>
                                                <a href="/student/evaluations/${evaluation.id}" class="btn btn-sm btn-outline-primary">Ver Detalles</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Rendimiento Académico</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="card bg-primary text-white">
                                    <div class="card-body">
                                        <h6 class="card-title">Promedio General</h6>
                                        <h2 class="mb-0">${averageGrade}</h2>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-success text-white">
                                    <div class="card-body">
                                        <h6 class="card-title">Asignaturas Aprobadas</h6>
                                        <h2 class="mb-0">${approvedSubjects}</h2>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-info text-white">
                                    <div class="card-body">
                                        <h6 class="card-title">Asignaturas en Curso</h6>
                                        <h2 class="mb-0">${currentSubjects}</h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:attribute>
</jsp:include> 