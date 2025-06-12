package com.example.demo.repository;

import com.example.demo.model.Evaluation;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface EvaluationRepository extends JpaRepository<Evaluation, Long> {
    List<Evaluation> findBySubjectId(Long subjectId);
    List<Evaluation> findBySubjectTeacherId(Long teacherId);
} 