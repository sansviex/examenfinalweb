package com.example.demo.service;

import javax.security.auth.Subject;

import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.stereotype.Service;

import com.example.demo.model.entity.Teacher;
import com.example.demo.repository.SubjectRepository;
import com.example.demo.repository.TeacherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;
import java.util.Optional;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import com.example.demo.model.dto.SubjectRequest;
import com.example.demo.model.dto.SubjectResponse;

@Service
@RequiredArgsConstructor
@Transactional
public class SubjectService {
    private final SubjectRepository subjectRepo;
    private final TeacherRepository teacherRepo;

    @Autowired
    private SubjectRepository subjectRepository;

    @Autowired
    private TeacherRepository teacherRepository;

    public SubjectResponse createSubject(SubjectRequest request) {
        Teacher teacher = teacherRepo.findById(request.getTeacherId())
                .orElseThrow(() -> new NotFoundException("Teacher not found"));
        
        Subject subject = Subject.builder()
                .title(request.getTitle())
                .teacher(teacher)
                .build();
        
        return SubjectResponse.from(subjectRepo.save(subject));
    }

    public List<Subject> getSubjectsByTeacher(Long teacherId) {
        return subjectRepository.findByTeacherId(teacherId);
    }

    public Optional<Subject> getSubjectById(Long id) {
        return subjectRepository.findById(id);
    }

    public Subject updateSubject(Subject subject) {
        return subjectRepository.save(subject);
    }

    public void deleteSubject(Long id) {
        subjectRepository.deleteById(id);
    }

    public Optional<SubjectResponse> getSubjectById(Long id) {
        return subjectRepository.findById(id)
                .map(SubjectResponse::from);
    }

    public List<SubjectResponse> getSubjectsByTeacher(Long teacherId) {
        return subjectRepository.findByTeacherId(teacherId)
                .stream()
                .map(SubjectResponse::from)
                .toList();
    }

    public SubjectResponse updateSubject(Long id, SubjectRequest request) {
        Subject subject = subjectRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Subject not found"));
        
        Teacher teacher = teacherRepo.findById(request.getTeacherId())
                .orElseThrow(() -> new NotFoundException("Teacher not found"));
        
        subject.setTitle(request.getTitle());
        subject.setTeacher(teacher);
        
        return SubjectResponse.from(subjectRepository.save(subject));
    }

    public void deleteSubject(Long id) {
        subjectRepository.deleteById(id);
    }
}