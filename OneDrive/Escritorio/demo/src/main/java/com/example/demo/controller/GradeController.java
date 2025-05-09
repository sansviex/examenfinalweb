package com.example.demo.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/grades")
@RequiredArgsConstructor
public class GradeController {
    private final GradeService gradeService;

    @PostMapping("/{evaluationId}")
    @PreAuthorize("hasRole('TEACHER')")
    public ResponseEntity<GradeResponse> gradeStudent(
            @PathVariable Long evaluationId,
            @RequestBody @Valid GradeRequest request) {
        return ResponseEntity.ok(gradeService.gradeStudent(evaluationId, request));
    }
}
