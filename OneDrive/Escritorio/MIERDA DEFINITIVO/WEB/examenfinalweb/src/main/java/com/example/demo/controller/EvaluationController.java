package com.example.demo.controller;

import com.example.demo.model.Evaluation;
import com.example.demo.model.Grade;
import com.example.demo.service.EvaluationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/evaluations")
public class EvaluationController {
    @Autowired
    private EvaluationService evaluationService;

    @PostMapping
    public ResponseEntity<Evaluation> createEvaluation(@RequestBody Evaluation evaluation) {
        return ResponseEntity.ok(evaluationService.createEvaluation(evaluation));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Evaluation> getEvaluationById(@PathVariable Long id) {
        return evaluationService.getEvaluationById(id)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/subject/{subjectId}")
    public ResponseEntity<List<Evaluation>> getEvaluationsBySubject(@PathVariable Long subjectId) {
        return ResponseEntity.ok(evaluationService.getEvaluationsBySubject(subjectId));
    }

    @GetMapping("/teacher/{teacherId}")
    public ResponseEntity<List<Evaluation>> getEvaluationsByTeacher(@PathVariable Long teacherId) {
        return ResponseEntity.ok(evaluationService.getEvaluationsByTeacher(teacherId));
    }

    @GetMapping("/{id}/grades")
    public ResponseEntity<List<Grade>> getGradesByEvaluation(@PathVariable Long id) {
        return ResponseEntity.ok(evaluationService.getGradesByEvaluation(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Evaluation> updateEvaluation(@PathVariable Long id, @RequestBody Evaluation evaluation) {
        evaluation.setId(id);
        return ResponseEntity.ok(evaluationService.updateEvaluation(evaluation));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEvaluation(@PathVariable Long id) {
        evaluationService.deleteEvaluation(id);
        return ResponseEntity.ok().build();
    }
} 