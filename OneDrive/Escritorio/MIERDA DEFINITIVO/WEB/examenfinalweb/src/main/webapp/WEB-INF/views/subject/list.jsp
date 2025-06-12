<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layouts/main.jsp">
    <jsp:param name="title" value="Asignaturas" />
    <jsp:attribute name="content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Asignaturas</h2>
            <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'TEACHER'}">
                <a href="/subjects/new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Nueva Asignatura
                </a>
            </c:if>
        </div>

        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Título</th>
                                <th>Profesor</th>
                                <th>Estudiantes</th>
                                <th>Horario</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${subjects}" var="subject">
                                <tr>
                                    <td>${subject.title}</td>
                                    <td>${subject.teacher.name}</td>
                                    <td>${subject.enrollments.size()} estudiantes</td>
                                    <td>
                                        <c:forEach items="${subject.schedules}" var="schedule">
                                            <div>${schedule.dayOfWeek} ${schedule.startTime}-${schedule.endTime}</div>
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="/subjects/${subject.id}" class="btn btn-sm btn-outline-primary">
                                                <i class="fas fa-eye"></i> Ver
                                            </a>
                                            <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'TEACHER'}">
                                                <a href="/subjects/${subject.id}/edit" class="btn btn-sm btn-outline-secondary">
                                                    <i class="fas fa-edit"></i> Editar
                                                </a>
                                                <a href="/subjects/${subject.id}/evaluations" class="btn btn-sm btn-outline-info">
                                                    <i class="fas fa-tasks"></i> Evaluaciones
                                                </a>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </jsp:attribute>
</jsp:include> 