<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layouts/main.jsp">
    <jsp:param name="title" value="${subject.title}" />
    <jsp:attribute name="content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>${subject.title}</h2>
            <div class="btn-group">
                <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'TEACHER'}">
                    <a href="/subjects/${subject.id}/edit" class="btn btn-primary">
                        <i class="fas fa-edit"></i> Editar
                    </a>
                </c:if>
                <a href="/subjects" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Volver
                </a>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Información General</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Profesor:</strong> ${subject.teacher.name}</p>
                                <p><strong>Créditos:</strong> ${subject.credits}</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Estado:</strong> 
                                    <span class="badge bg-${subject.active ? 'success' : 'danger'}">
                                        ${subject.active ? 'Activa' : 'Inactiva'}
                                    </span>
                                </p>
                                <p><strong>Estudiantes:</strong> ${subject.enrollments.size()}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Horario</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Día</th>
                                        <th>Hora Inicio</th>
                                        <th>Hora Fin</th>
                                        <th>Aula</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${subject.schedules}" var="schedule">
                                        <tr>
                                            <td>${schedule.dayOfWeek}</td>
                                            <td>${schedule.startTime}</td>
                                            <td>${schedule.endTime}</td>
                                            <td>${schedule.classroom}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Estudiantes Matriculados</h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group">
                            <c:forEach items="${subject.enrollments}" var="enrollment">
                                <div class="list-group-item">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-0">${enrollment.student.name}</h6>
                                            <small class="text-muted">${enrollment.student.email}</small>
                                        </div>
                                        <span class="badge bg-${enrollment.status == 'ACTIVE' ? 'success' : 'warning'}">
                                            ${enrollment.status}
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Evaluaciones Recientes</h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group">
                            <c:forEach items="${subject.evaluations}" var="evaluation">
                                <div class="list-group-item">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="mb-0">${evaluation.title}</h6>
                                            <small class="text-muted">${evaluation.date}</small>
                                        </div>
                                        <span class="badge bg-info">${evaluation.type}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:attribute>
</jsp:include> 