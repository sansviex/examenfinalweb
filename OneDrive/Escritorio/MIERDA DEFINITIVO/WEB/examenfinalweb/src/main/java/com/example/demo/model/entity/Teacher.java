package com.example.demo.model.entity;

import java.util.List;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;

@Entity
@DiscriminatorValue("TEACHER")
public class Teacher extends User {
    @OneToMany(mappedBy = "teacher")
    private List<TeacherSchedule> availableSchedules;
    
    @OneToMany(mappedBy = "teacher")
    private List<UnavailableTime> unavailableTimes;
}