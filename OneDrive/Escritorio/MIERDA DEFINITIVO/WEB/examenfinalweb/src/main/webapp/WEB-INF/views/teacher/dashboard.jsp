<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layouts/main.jsp">
    <jsp:param name="title" value="Dashboard Profesor" />
    <jsp:attribute name="content">
        <div class="row">
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Mis Asignaturas</h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty subjects}">
                            <p class="text-muted">No tienes asignaturas asignadas.</p>
                        </c:if>
                        <c:forEach items="${subjects}" var="subject">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span>${subject.title}</span>
                                <a href="/teacher/subjects/${subject.id}" class="btn btn-sm btn-outline-primary">Ver Detalles</a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Horario de Clases</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Día</th>
                                        <th>Hora</th>
                                        <th>Asignatura</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${schedules}" var="schedule">
                                        <tr>
                                            <td>${schedule.dayOfWeek}</td>
                                            <td>${schedule.startTime} - ${schedule.endTime}</td>
                                            <td>${schedule.subject.title}</td>
                                            <td>
                                                <a href="/teacher/schedule/${schedule.id}" class="btn btn-sm btn-outline-primary">Ver Detalles</a>
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
                                        <th>Estado</th>
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
                                                <span class="badge bg-${evaluation.status == 'PENDING' ? 'warning' : 'success'}">
                                                    ${evaluation.status}
                                                </span>
                                            </td>
                                            <td>
                                                <a href="/teacher/evaluations/${evaluation.id}" class="btn btn-sm btn-outline-primary">Ver Detalles</a>
                                                <a href="/teacher/evaluations/${evaluation.id}/grades" class="btn btn-sm btn-outline-success">Calificar</a>
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
    </jsp:attribute>
</jsp:include> 