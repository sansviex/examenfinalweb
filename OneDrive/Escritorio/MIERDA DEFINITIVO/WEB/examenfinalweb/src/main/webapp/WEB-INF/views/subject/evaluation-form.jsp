<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layouts/main.jsp">
    <jsp:param name="title" value="${evaluation.id == null ? 'Nueva Evaluación' : 'Editar Evaluación'}" />
    <jsp:attribute name="content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>${evaluation.id == null ? 'Nueva Evaluación' : 'Editar Evaluación'}</h2>
            <a href="/subjects/${subject.id}/evaluations" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Volver
            </a>
        </div>

        <div class="card">
            <div class="card-body">
                <form action="/subjects/${subject.id}/evaluations${evaluation.id == null ? '' : '/' + evaluation.id}" 
                      method="POST" class="needs-validation" novalidate>
                    <c:if test="${evaluation.id != null}">
                        <input type="hidden" name="_method" value="PUT">
                    </c:if>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="title" class="form-label">Título</label>
                            <input type="text" class="form-control" id="title" name="title" 
                                   value="${evaluation.title}" required>
                            <div class="invalid-feedback">
                                Por favor ingrese el título de la evaluación
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="type" class="form-label">Tipo</label>
                            <select class="form-select" id="type" name="type" required>
                                <option value="">Seleccione un tipo</option>
                                <option value="EXAM" ${evaluation.type == 'EXAM' ? 'selected' : ''}>Examen</option>
                                <option value="QUIZ" ${evaluation.type == 'QUIZ' ? 'selected' : ''}>Quiz</option>
                                <option value="PROJECT" ${evaluation.type == 'PROJECT' ? 'selected' : ''}>Proyecto</option>
                                <option value="HOMEWORK" ${evaluation.type == 'HOMEWORK' ? 'selected' : ''}>Tarea</option>
                            </select>
                            <div class="invalid-feedback">
                                Por favor seleccione el tipo de evaluación
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="date" class="form-label">Fecha</label>
                            <input type="date" class="form-control" id="date" name="date" 
                                   value="${evaluation.date}" required>
                            <div class="invalid-feedback">
                                Por favor seleccione la fecha
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="weight" class="form-label">Peso (%)</label>
                            <input type="number" class="form-control" id="weight" name="weight" 
                                   value="${evaluation.weight}" required min="1" max="100">
                            <div class="invalid-feedback">
                                Por favor ingrese el peso (1-100)
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="status" class="form-label">Estado</label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="PENDING" ${evaluation.status == 'PENDING' ? 'selected' : ''}>Pendiente</option>
                                <option value="IN_PROGRESS" ${evaluation.status == 'IN_PROGRESS' ? 'selected' : ''}>En Progreso</option>
                                <option value="COMPLETED" ${evaluation.status == 'COMPLETED' ? 'selected' : ''}>Completada</option>
                                <option value="CANCELLED" ${evaluation.status == 'CANCELLED' ? 'selected' : ''}>Cancelada</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="maxScore" class="form-label">Puntaje Máximo</label>
                            <input type="number" class="form-control" id="maxScore" name="maxScore" 
                                   value="${evaluation.maxScore}" required min="1" max="100">
                            <div class="invalid-feedback">
                                Por favor ingrese el puntaje máximo
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Descripción</label>
                        <textarea class="form-control" id="description" name="description" 
                                  rows="4" required>${evaluation.description}</textarea>
                        <div class="invalid-feedback">
                            Por favor ingrese una descripción
                        </div>
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