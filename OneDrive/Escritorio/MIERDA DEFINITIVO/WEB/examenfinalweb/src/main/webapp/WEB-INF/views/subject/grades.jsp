<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layouts/main.jsp">
    <jsp:param name="title" value="Calificaciones - ${evaluation.title}" />
    <jsp:attribute name="content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Calificaciones - ${evaluation.title}</h2>
            <a href="/subjects/${subject.id}/evaluations" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Volver
            </a>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <form action="/subjects/${subject.id}/evaluations/${evaluation.id}/grades" method="POST">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Estudiante</th>
                                            <th>Calificación</th>
                                            <th>Comentarios</th>
                                            <th>Estado</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${grades}" var="grade" varStatus="status">
                                            <tr>
                                                <td>
                                                    <input type="hidden" name="grades[${status.index}].student.id" value="${grade.student.id}">
                                                    ${grade.student.name}
                                                </td>
                                                <td>
                                                    <input type="number" class="form-control" 
                                                           name="grades[${status.index}].score" 
                                                           value="${grade.score}"
                                                           min="0" max="${evaluation.maxScore}" step="0.1" required>
                                                </td>
                                                <td>
                                                    <input type="text" class="form-control" 
                                                           name="grades[${status.index}].comments" 
                                                           value="${grade.comments}">
                                                </td>
                                                <td>
                                                    <select class="form-select" name="grades[${status.index}].status">
                                                        <option value="PENDING" ${grade.status == 'PENDING' ? 'selected' : ''}>Pendiente</option>
                                                        <option value="GRADED" ${grade.status == 'GRADED' ? 'selected' : ''}>Calificado</option>
                                                        <option value="REVIEWED" ${grade.status == 'REVIEWED' ? 'selected' : ''}>Revisado</option>
                                                    </select>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="text-end mt-3">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Guardar Calificaciones
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Resumen de Calificaciones</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <h6>Promedio</h6>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" 
                                     style="width: ${evaluation.averageScore}%;" 
                                     aria-valuenow="${evaluation.averageScore}" 
                                     aria-valuemin="0" 
                                     aria-valuemax="100">
                                    ${evaluation.averageScore}%
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <h6>Distribución</h6>
                            <div class="list-group">
                                <div class="list-group-item d-flex justify-content-between align-items-center">
                                    Excelente (90-100)
                                    <span class="badge bg-success rounded-pill">${evaluation.gradeDistribution.excellent}</span>
                                </div>
                                <div class="list-group-item d-flex justify-content-between align-items-center">
                                    Bueno (80-89)
                                    <span class="badge bg-info rounded-pill">${evaluation.gradeDistribution.good}</span>
                                </div>
                                <div class="list-group-item d-flex justify-content-between align-items-center">
                                    Regular (70-79)
                                    <span class="badge bg-warning rounded-pill">${evaluation.gradeDistribution.fair}</span>
                                </div>
                                <div class="list-group-item d-flex justify-content-between align-items-center">
                                    Deficiente (0-69)
                                    <span class="badge bg-danger rounded-pill">${evaluation.gradeDistribution.poor}</span>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <h6>Estadísticas</h6>
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Calificación más alta
                                    <span class="badge bg-primary rounded-pill">${evaluation.highestScore}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Calificación más baja
                                    <span class="badge bg-primary rounded-pill">${evaluation.lowestScore}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Desviación estándar
                                    <span class="badge bg-primary rounded-pill">${evaluation.standardDeviation}</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Acciones Rápidas</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <button type="button" class="btn btn-outline-primary" id="export-grades">
                                <i class="fas fa-file-export"></i> Exportar Calificaciones
                            </button>
                            <button type="button" class="btn btn-outline-info" id="send-notifications">
                                <i class="fas fa-bell"></i> Enviar Notificaciones
                            </button>
                            <button type="button" class="btn btn-outline-warning" id="request-reviews">
                                <i class="fas fa-sync"></i> Solicitar Revisiones
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Exportar calificaciones
                document.getElementById('export-grades').addEventListener('click', function() {
                    window.location.href = '/subjects/${subject.id}/evaluations/${evaluation.id}/grades/export';
                });

                // Enviar notificaciones
                document.getElementById('send-notifications').addEventListener('click', function() {
                    if (confirm('¿Desea enviar notificaciones a todos los estudiantes?')) {
                        window.location.href = '/subjects/${subject.id}/evaluations/${evaluation.id}/grades/notify';
                    }
                });

                // Solicitar revisiones
                document.getElementById('request-reviews').addEventListener('click', function() {
                    if (confirm('¿Desea solicitar revisiones de calificaciones?')) {
                        window.location.href = '/subjects/${subject.id}/evaluations/${evaluation.id}/grades/review';
                    }
                });
            });
        </script>
    </jsp:attribute>
</jsp:include> 