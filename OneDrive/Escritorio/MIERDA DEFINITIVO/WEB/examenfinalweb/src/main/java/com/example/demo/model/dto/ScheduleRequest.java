package com.example.demo.model.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ScheduleRequest {
    @NotBlank(message = "El día de la semana es requerido")
    private String dayOfWeek;
    
    @NotBlank(message = "La hora de inicio es requerida")
    private String startTime;
    
    @NotBlank(message = "La hora de fin es requerida")
    private String endTime;
    
    @NotBlank(message = "El aula es requerida")
    private String classroom;
    
    @NotNull(message = "El ID de la asignatura es requerido")
    private Long subjectId;
}
