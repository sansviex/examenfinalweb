package com.example.demo.controller;

import com.example.demo.model.Grade;
import com.example.demo.model.Teacher;
import com.example.demo.service.GradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/grades")
public class GradeController {
    @Autowired
    private GradeService gradeService;

    @PostMapping
    public ResponseEntity<Grade> createGrade(@RequestBody Grade grade) {
        return ResponseEntity.ok(gradeService.createGrade(grade));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Grade> updateGrade(
            @PathVariable Long id,
            @RequestBody Grade grade,
            @RequestParam Long teacherId) {
        Teacher teacher = new Teacher();
        teacher.setId(teacherId);
        grade.setId(id);
        return ResponseEntity.ok(gradeService.updateGrade(grade, teacher));
    }

    @GetMapping("/student/{studentId}")
    public ResponseEntity<List<Grade>> getGradesByStudent(@PathVariable Long studentId) {
        return ResponseEntity.ok(gradeService.getGradesByStudent(studentId));
    }

    @GetMapping("/subject/{subjectId}")
    public ResponseEntity<List<Grade>> getGradesBySubject(@PathVariable Long subjectId) {
        return ResponseEntity.ok(gradeService.getGradesBySubject(subjectId));
    }
}
