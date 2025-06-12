package com.example.demo.service;

import com.example.demo.model.AuditTrail;
import com.example.demo.model.User;
import com.example.demo.repository.AuditTrailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class AuditService {
    @Autowired
    private AuditTrailRepository auditTrailRepository;

    public AuditTrail logAction(User user, String action, String entityAffected) {
        AuditTrail auditTrail = new AuditTrail();
        auditTrail.setUser(user);
        auditTrail.setAction(action);
        auditTrail.setEntityAffected(entityAffected);
        auditTrail.setTimestamp(LocalDateTime.now());
        return auditTrailRepository.save(auditTrail);
    }

    public List<AuditTrail> getAuditTrailByUser(Long userId) {
        return auditTrailRepository.findByUserId(userId);
    }

    public List<AuditTrail> getAuditTrailByEntity(String entityAffected) {
        return auditTrailRepository.findByEntityAffected(entityAffected);
    }
} 