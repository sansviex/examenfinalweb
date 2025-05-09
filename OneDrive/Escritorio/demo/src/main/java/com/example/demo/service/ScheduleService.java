package com.example.demo.service;

import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.stereotype.Service;

import com.example.demo.model.entity.Teacher;
import com.example.demo.model.entity.TeacherSchedule;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ScheduleService {
    private final TeacherScheduleRepository teacherScheduleRepo;
    private final SubjectRepository subjectRepo;

    public TeacherSchedule createTeacherSchedule(Long teacherId, ScheduleRequest request) {
        Teacher teacher = teacherRepo.findById(teacherId)
                .orElseThrow(() -> new NotFoundException("Teacher not found"));
        
        TeacherSchedule schedule = TeacherSchedule.builder()
                .teacher(teacher)
                .dayOfWeek(request.getDayOfWeek())
                .startTime(request.getStartTime())
                .endTime(request.getEndTime())
                .build();
        
        return teacherScheduleRepo.save(schedule);
    }
}