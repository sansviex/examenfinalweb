package com.example.demo.model.dto;

import com.example.demo.model.entity.Subject;
import lombok.Data;
import java.util.List;
import java.util.stream.Collectors;

@Data
public class SubjectResponse {
    private Long id;
    private String title;
    private Integer credits;
    private Long teacherId;
    private String teacherName;
    private Boolean active;
    private List<ScheduleResponse> schedules;
    private Integer enrolledStudents;
    
    @Data
    public static class ScheduleResponse {
        private String dayOfWeek;
        private String startTime;
        private String endTime;
        private String classroom;
    }
    
    public static SubjectResponse from(Subject subject) {
        SubjectResponse response = new SubjectResponse();
        response.setId(subject.getId());
        response.setTitle(subject.getTitle());
        response.setCredits(subject.getCredits());
        response.setTeacherId(subject.getTeacher().getId());
        response.setTeacherName(subject.getTeacher().getName());
        response.setActive(subject.getActive());
        response.setEnrolledStudents(subject.getEnrollments().size());
        
        response.setSchedules(subject.getSchedules().stream()
            .map(schedule -> {
                ScheduleResponse scheduleResponse = new ScheduleResponse();
                scheduleResponse.setDayOfWeek(schedule.getDayOfWeek());
                scheduleResponse.setStartTime(schedule.getStartTime());
                scheduleResponse.setEndTime(schedule.getEndTime());
                scheduleResponse.setClassroom(schedule.getClassroom());
                return scheduleResponse;
            })
            .collect(Collectors.toList()));
            
        return response;
    }
} 