package com.example.demo.service.impl;

import com.example.demo.model.dto.SubjectRequest;
import com.example.demo.model.dto.SubjectResponse;
import com.example.demo.model.entity.Subject;
import com.example.demo.repository.SubjectRepository;
import com.example.demo.service.SubjectService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class SubjectServiceImpl implements SubjectService {
    private final SubjectRepository subjectRepository;

    @Override
    public SubjectResponse createSubject(SubjectRequest request) {
        Subject subject = new Subject();
        subject.setTitle(request.getTitle());
        subject.setCredits(request.getCredits());
        return SubjectResponse.from(subjectRepository.save(subject));
    }

    @Override
    public Optional<SubjectResponse> getSubjectById(Long id) {
        return subjectRepository.findById(id)
                .map(SubjectResponse::from);
    }

    @Override
    public List<SubjectResponse> getSubjectsByTeacher(Long teacherId) {
        return subjectRepository.findByTeacherId(teacherId).stream()
                .map(SubjectResponse::from)
                .toList();
    }

    @Override
    public SubjectResponse updateSubject(Long id, SubjectRequest request) {
        Subject subject = subjectRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Subject not found"));
        subject.setTitle(request.getTitle());
        subject.setCredits(request.getCredits());
        return SubjectResponse.from(subjectRepository.save(subject));
    }

    @Override
    public void deleteSubject(Long id) {
        subjectRepository.deleteById(id);
    }
} 