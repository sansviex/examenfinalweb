package com.example.demo.service;

import javax.security.auth.Subject;

import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.stereotype.Service;

import com.example.demo.model.entity.Teacher;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class SubjectService {
    private final SubjectRepository subjectRepo;
    private final TeacherRepository teacherRepo;

    public SubjectResponse createSubject(SubjectRequest request) {
        Teacher teacher = teacherRepo.findById(request.getTeacherId())
                .orElseThrow(() -> new NotFoundException("Teacher not found"));
        
        Subject subject = Subject.builder()
                .title(request.getTitle())
                .teacher(teacher)
                .build();
        
        return SubjectResponse.from(subjectRepo.save(subject));
    }
}