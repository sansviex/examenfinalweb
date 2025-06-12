package com.example.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import java.util.ArrayList;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@Entity
@Table(name = "teachers")
public class Teacher extends User {
    
    @OneToMany(mappedBy = "teacher", cascade = CascadeType.ALL)
    private List<TeacherSchedule> availableSchedules = new ArrayList<>();

    @OneToMany(mappedBy = "teacher", cascade = CascadeType.ALL)
    private List<UnavailableTime> unavailableTimes = new ArrayList<>();

    @OneToMany(mappedBy = "teacher", cascade = CascadeType.ALL)
    private List<Subject> subjects = new ArrayList<>();

    public Teacher(String name, String email, String password) {
        super(name, email, password, RoleEnum.TEACHER);
    }
} 