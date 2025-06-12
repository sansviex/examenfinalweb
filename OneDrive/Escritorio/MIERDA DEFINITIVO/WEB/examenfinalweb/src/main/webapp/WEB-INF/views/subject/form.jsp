<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layouts/main.jsp">
    <jsp:param name="title" value="${subject.id == null ? 'Nueva Asignatura' : 'Editar Asignatura'}" />
    <jsp:attribute name="content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>${subject.id == null ? 'Nueva Asignatura' : 'Editar Asignatura'}</h2>
            <a href="/subjects" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Volver
            </a>
        </div>

        <div class="card">
            <div class="card-body">
                <form action="/subjects${subject.id == null ? '' : '/' + subject.id}" method="POST" class="needs-validation" novalidate>
                    <c:if test="${subject.id != null}">
                        <input type="hidden" name="_method" value="PUT">
                    </c:if>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="title" class="form-label">Título</label>
                            <input type="text" class="form-control" id="title" name="title" value="${subject.title}" required>
                            <div class="invalid-feedback">
                                Por favor ingrese el título de la asignatura
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="credits" class="form-label">Créditos</label>
                            <input type="number" class="form-control" id="credits" name="credits" value="${subject.credits}" required min="1" max="10">
                            <div class="invalid-feedback">
                                Por favor ingrese los créditos (1-10)
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="teacher" class="form-label">Profesor</label>
                            <select class="form-select" id="teacher" name="teacher.id" required>
                                <option value="">Seleccione un profesor</option>
                                <c:forEach items="${teachers}" var="teacher">
                                    <option value="${teacher.id}" ${subject.teacher.id == teacher.id ? 'selected' : ''}>
                                        ${teacher.name}
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">
                                Por favor seleccione un profesor
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="active" class="form-label">Estado</label>
                            <select class="form-select" id="active" name="active">
                                <option value="true" ${subject.active ? 'selected' : ''}>Activa</option>
                                <option value="false" ${!subject.active ? 'selected' : ''}>Inactiva</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-4">
                        <h5>Horarios</h5>
                        <div id="schedules">
                            <c:forEach items="${subject.schedules}" var="schedule" varStatus="status">
                                <div class="row mb-3 schedule-row">
                                    <div class="col-md-3">
                                        <label class="form-label">Día</label>
                                        <select class="form-select" name="schedules[${status.index}].dayOfWeek" required>
                                            <option value="LUNES" ${schedule.dayOfWeek == 'LUNES' ? 'selected' : ''}>Lunes</option>
                                            <option value="MARTES" ${schedule.dayOfWeek == 'MARTES' ? 'selected' : ''}>Martes</option>
                                            <option value="MIERCOLES" ${schedule.dayOfWeek == 'MIERCOLES' ? 'selected' : ''}>Miércoles</option>
                                            <option value="JUEVES" ${schedule.dayOfWeek == 'JUEVES' ? 'selected' : ''}>Jueves</option>
                                            <option value="VIERNES" ${schedule.dayOfWeek == 'VIERNES' ? 'selected' : ''}>Viernes</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label">Hora Inicio</label>
                                        <input type="time" class="form-control" name="schedules[${status.index}].startTime" value="${schedule.startTime}" required>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label">Hora Fin</label>
                                        <input type="time" class="form-control" name="schedules[${status.index}].endTime" value="${schedule.endTime}" required>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-label">Aula</label>
                                        <input type="text" class="form-control" name="schedules[${status.index}].classroom" value="${schedule.classroom}" required>
                                    </div>
                                    <div class="col-md-1 d-flex align-items-end">
                                        <button type="button" class="btn btn-danger remove-schedule">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <button type="button" class="btn btn-secondary" id="add-schedule">
                            <i class="fas fa-plus"></i> Agregar Horario
                        </button>
                    </div>

                    <div class="text-end">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Guardar
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const schedulesContainer = document.getElementById('schedules');
                const addScheduleBtn = document.getElementById('add-schedule');
                let scheduleCount = ${subject.schedules.size()};

                addScheduleBtn.addEventListener('click', function() {
                    const scheduleRow = document.createElement('div');
                    scheduleRow.className = 'row mb-3 schedule-row';
                    scheduleRow.innerHTML = `
                        <div class="col-md-3">
                            <label class="form-label">Día</label>
                            <select class="form-select" name="schedules[${scheduleCount}].dayOfWeek" required>
                                <option value="LUNES">Lunes</option>
                                <option value="MARTES">Martes</option>
                                <option value="MIERCOLES">Miércoles</option>
                                <option value="JUEVES">Jueves</option>
                                <option value="VIERNES">Viernes</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Hora Inicio</label>
                            <input type="time" class="form-control" name="schedules[${scheduleCount}].startTime" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Hora Fin</label>
                            <input type="time" class="form-control" name="schedules[${scheduleCount}].endTime" required>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Aula</label>
                            <input type="text" class="form-control" name="schedules[${scheduleCount}].classroom" required>
                        </div>
                        <div class="col-md-1 d-flex align-items-end">
                            <button type="button" class="btn btn-danger remove-schedule">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    `;
                    schedulesContainer.appendChild(scheduleRow);
                    scheduleCount++;
                });

                schedulesContainer.addEventListener('click', function(e) {
                    if (e.target.closest('.remove-schedule')) {
                        e.target.closest('.schedule-row').remove();
                    }
                });

                // Form validation
                const form = document.querySelector('form');
                form.addEventListener('submit', function(event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                });
            });
        </script>
    </jsp:attribute>
</jsp:include> 