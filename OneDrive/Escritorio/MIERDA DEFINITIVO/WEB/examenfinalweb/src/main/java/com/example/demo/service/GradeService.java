package com.example.demo.service;

import com.example.demo.model.Grade;
import com.example.demo.model.GradeHistory;
import com.example.demo.model.Teacher;
import com.example.demo.repository.GradeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class GradeService {
    @Autowired
    private GradeRepository gradeRepository;

    public Grade createGrade(Grade grade) {
        grade.setTimestamp(LocalDateTime.now());
        return gradeRepository.save(grade);
    }

    public Grade updateGrade(Grade grade, Teacher modifiedBy) {
        Grade existingGrade = gradeRepository.findById(grade.getId())
            .orElseThrow(() -> new RuntimeException("Grade not found"));

        GradeHistory history = new GradeHistory();
        history.setGrade(existingGrade);
        history.setOldScore(existingGrade.getScore());
        history.setNewScore(grade.getScore());
        history.setModifiedBy(modifiedBy);
        history.setModificationDate(LocalDateTime.now());

        existingGrade.getHistory().add(history);
        existingGrade.setScore(grade.getScore());
        existingGrade.setTimestamp(LocalDateTime.now());

        return gradeRepository.save(existingGrade);
    }

    public List<Grade> getGradesByStudent(Long studentId) {
        return gradeRepository.findByStudentId(studentId);
    }

    public List<Grade> getGradesBySubject(Long subjectId) {
        return gradeRepository.findByEvaluationSubjectId(subjectId);
    }
} 