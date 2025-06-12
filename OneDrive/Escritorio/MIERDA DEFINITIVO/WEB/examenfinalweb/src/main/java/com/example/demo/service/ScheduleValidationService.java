package com.example.demo.service;

import com.example.demo.model.SubjectSchedule;
import com.example.demo.model.TeacherSchedule;
import com.example.demo.model.UnavailableTime;
import org.springframework.stereotype.Service;
import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Service
public class ScheduleValidationService {

    public boolean isScheduleValid(SubjectSchedule newSchedule, List<TeacherSchedule> teacherSchedules,
            List<UnavailableTime> unavailableTimes, List<SubjectSchedule> existingSchedules) {
        
        // Verificar disponibilidad del profesor
        if (!isTeacherAvailable(newSchedule, teacherSchedules)) {
            return false;
        }

        // Verificar que no coincida con tiempos no disponibles
        if (hasUnavailableTimeConflict(newSchedule, unavailableTimes)) {
            return false;
        }

        // Verificar que no haya conflictos con otros horarios
        if (hasScheduleConflict(newSchedule, existingSchedules)) {
            return false;
        }

        return true;
    }

    private boolean isTeacherAvailable(SubjectSchedule schedule, List<TeacherSchedule> teacherSchedules) {
        return teacherSchedules.stream()
            .anyMatch(ts -> ts.getDayOfWeek() == schedule.getDayOfWeek() &&
                    isTimeRangeOverlap(ts.getStartTime(), ts.getEndTime(),
                            schedule.getStartTime(), schedule.getEndTime()));
    }

    private boolean hasUnavailableTimeConflict(SubjectSchedule schedule, List<UnavailableTime> unavailableTimes) {
        return unavailableTimes.stream()
            .anyMatch(ut -> {
                LocalDateTime scheduleStart = LocalDateTime.now()
                    .with(schedule.getDayOfWeek())
                    .with(schedule.getStartTime());
                LocalDateTime scheduleEnd = LocalDateTime.now()
                    .with(schedule.getDayOfWeek())
                    .with(schedule.getEndTime());
                return isDateTimeRangeOverlap(ut.getStartDateTime(), ut.getEndDateTime(),
                        scheduleStart, scheduleEnd);
            });
    }

    private boolean hasScheduleConflict(SubjectSchedule newSchedule, List<SubjectSchedule> existingSchedules) {
        return existingSchedules.stream()
            .anyMatch(es -> es.getDayOfWeek() == newSchedule.getDayOfWeek() &&
                    isTimeRangeOverlap(es.getStartTime(), es.getEndTime(),
                            newSchedule.getStartTime(), newSchedule.getEndTime()));
    }

    private boolean isTimeRangeOverlap(LocalTime start1, LocalTime end1, LocalTime start2, LocalTime end2) {
        return !start1.isAfter(end2) && !start2.isAfter(end1);
    }

    private boolean isDateTimeRangeOverlap(LocalDateTime start1, LocalDateTime end1,
            LocalDateTime start2, LocalDateTime end2) {
        return !start1.isAfter(end2) && !start2.isAfter(end1);
    }
} 