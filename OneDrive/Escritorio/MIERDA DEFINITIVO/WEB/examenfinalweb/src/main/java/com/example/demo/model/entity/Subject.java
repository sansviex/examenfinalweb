package com.example.demo.model.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "subjects")
public class Subject {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String title;
    private Integer credits;
    private Boolean active = true;
    
    @ManyToOne
    @JoinColumn(name = "teacher_id")
    private Teacher teacher;
    
    @OneToMany(mappedBy = "subject", cascade = CascadeType.ALL)
    private List<Enrollment> enrollments = new ArrayList<>();
    
    @OneToMany(mappedBy = "subject", cascade = CascadeType.ALL)
    private List<Schedule> schedules = new ArrayList<>();
} 