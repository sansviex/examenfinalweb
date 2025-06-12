package com.example.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@Entity
@Table(name = "grade_history")
public class GradeHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "grade_id", nullable = false)
    private Grade grade;

    @Column(nullable = false)
    private double oldScore;

    @Column(nullable = false)
    private double newScore;

    @ManyToOne
    @JoinColumn(name = "modified_by_id", nullable = false)
    private Teacher modifiedBy;

    @Column(nullable = false)
    private LocalDateTime modificationDate;
} 