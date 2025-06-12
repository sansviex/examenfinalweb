package com.example.demo.service;

import com.example.demo.model.Evaluation;
import com.example.demo.model.Grade;
import com.example.demo.repository.EvaluationRepository;
import com.example.demo.repository.GradeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class EvaluationService {
    @Autowired
    private EvaluationRepository evaluationRepository;

    @Autowired
    private GradeRepository gradeRepository;

    public Evaluation createEvaluation(Evaluation evaluation) {
        return evaluationRepository.save(evaluation);
    }

    public List<Evaluation> getEvaluationsBySubject(Long subjectId) {
        return evaluationRepository.findBySubjectId(subjectId);
    }

    public List<Evaluation> getEvaluationsByTeacher(Long teacherId) {
        return evaluationRepository.findBySubjectTeacherId(teacherId);
    }

    public Optional<Evaluation> getEvaluationById(Long id) {
        return evaluationRepository.findById(id);
    }

    public Evaluation updateEvaluation(Evaluation evaluation) {
        return evaluationRepository.save(evaluation);
    }

    public void deleteEvaluation(Long id) {
        evaluationRepository.deleteById(id);
    }

    public List<Grade> getGradesByEvaluation(Long evaluationId) {
        return gradeRepository.findByEvaluationId(evaluationId);
    }
} 