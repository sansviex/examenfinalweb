<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layouts/main.jsp">
    <jsp:param name="title" value="Evaluaciones - ${subject.title}" />
    <jsp:attribute name="content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Evaluaciones - ${subject.title}</h2>
            <div class="btn-group">
                <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'TEACHER'}">
                    <a href="/subjects/${subject.id}/evaluations/new" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nueva Evaluación
                    </a>
                </c:if>
                <a href="/subjects/${subject.id}" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Volver
                </a>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Título</th>
                                        <th>Tipo</th>
                                        <th>Fecha</th>
                                        <th>Peso</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${subject.evaluations}" var="evaluation">
                                        <tr>
                                            <td>${evaluation.title}</td>
                                            <td>
                                                <span class="badge bg-${evaluation.type == 'EXAM' ? 'danger' : 'info'}">
                                                    ${evaluation.type}
                                                </span>
                                            </td>
                                            <td>${evaluation.date}</td>
                                            <td>${evaluation.weight}%</td>
                                            <td>
                                                <span class="badge bg-${evaluation.status == 'PENDING' ? 'warning' : 
                                                                      evaluation.status == 'IN_PROGRESS' ? 'info' : 
                                                                      evaluation.status == 'COMPLETED' ? 'success' : 'secondary'}">
                                                    ${evaluation.status}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <a href="/subjects/${subject.id}/evaluations/${evaluation.id}" class="btn btn-sm btn-outline-primary">
                                                        <i class="fas fa-eye"></i> Ver
                                                    </a>
                                                    <c:if test="${sessionScope.user.role == 'ADMIN' || sessionScope.user.role == 'TEACHER'}">
                                                        <a href="/subjects/${subject.id}/evaluations/${evaluation.id}/edit" class="btn btn-sm btn-outline-secondary">
                                                            <i class="fas fa-edit"></i> Editar
                                                        </a>
                                                        <a href="/subjects/${subject.id}/evaluations/${evaluation.id}/grades" class="btn btn-sm btn-outline-info">
                                                            <i class="fas fa-star"></i> Calificaciones
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
            </div>

            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Resumen de Calificaciones</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <h6>Promedio General</h6>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" style="width: ${subject.averageGrade}%;" 
                                     aria-valuenow="${subject.averageGrade}" aria-valuemin="0" aria-valuemax="100">
                                    ${subject.averageGrade}%
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <h6>Distribución de Calificaciones</h6>
                            <div class="list-group">
                                <div class="list-group-item d-flex justify-content-between align-items-center">
                                    Excelente (90-100)
                                    <span class="badge bg-success rounded-pill">${subject.gradeDistribution.excellent}</span>
                                </div>
                                <div class="list-group-item d-flex justify-content-between align-items-center">
                                    Bueno (80-89)
                                    <span class="badge bg-info rounded-pill">${subject.gradeDistribution.good}</span>
                                </div>
                                <div class="list-group-item d-flex justify-content-between align-items-center">
                                    Regular (70-79)
                                    <span class="badge bg-warning rounded-pill">${subject.gradeDistribution.fair}</span>
                                </div>
                                <div class="list-group-item d-flex justify-content-between align-items-center">
                                    Deficiente (0-69)
                                    <span class="badge bg-danger rounded-pill">${subject.gradeDistribution.poor}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:attribute>
</jsp:include> 