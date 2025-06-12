package com.example.demo.model.entity;

import java.util.List;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;

@Entity
@DiscriminatorValue("STUDENT")
public class Student extends User {
    @OneToMany(mappedBy = "student")
    private List<SubjectEnrollment> enrolledSubjects;
}
