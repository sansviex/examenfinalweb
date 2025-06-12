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
@Table(name = "students")
public class Student extends User {
    
    @OneToMany(mappedBy = "student", cascade = CascadeType.ALL)
    private List<SubjectEnrollment> enrollments = new ArrayList<>();

    public Student(String name, String email, String password) {
        super(name, email, password, RoleEnum.STUDENT);
    }
} 