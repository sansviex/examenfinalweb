package com.example.demo.model.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Max;
import lombok.Data;

@Data
public class SubjectRequest {
    @NotBlank(message = "El título es requerido")
    private String title;
    
    @NotNull(message = "Los créditos son requeridos")
    @Min(value = 1, message = "Los créditos deben ser al menos 1")
    @Max(value = 10, message = "Los créditos no pueden ser más de 10")
    private Integer credits;
    
    @NotNull(message = "El ID del profesor es requerido")
    private Long teacherId;
    
    private Boolean active = true;
} 