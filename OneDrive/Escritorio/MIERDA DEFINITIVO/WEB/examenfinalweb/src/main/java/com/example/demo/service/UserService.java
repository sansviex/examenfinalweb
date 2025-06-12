package com.example.demo.service;

import javax.naming.AuthenticationException;

import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.demo.model.entity.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.model.dto.UserRequest;
import com.example.demo.model.dto.UserResponse;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class UserService {
    private final UserRepository userRepo;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    private UserRepository userRepository;

    public UserResponse getUserProfile(Long userId) {
        return userRepo.findById(userId)
                .map(UserResponse::from)
                .orElseThrow(() -> new NotFoundException("User not found"));
    }

    public User authenticate(String email, String password) {
        User user = userRepo.findByEmail(email)
                .orElseThrow(() -> new NotFoundException("User not found"));
        
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new AuthenticationException("Invalid credentials");
        }
        
        return user;
    }

    public User createUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }

    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User updateUser(User user) {
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }
        return userRepository.save(user);
    }

    public UserResponse createUser(UserRequest request) {
        // Implementation of createUser method
        return null; // Placeholder return, actual implementation needed
    }

    public Optional<UserResponse> getUserById(Long id) {
        // Implementation of getUserById method
        return Optional.empty(); // Placeholder return, actual implementation needed
    }

    public UserResponse updateUser(Long id, UserRequest request) {
        // Implementation of updateUser method
        return null; // Placeholder return, actual implementation needed
    }

    public void deleteUser(Long id) {
        // Implementation of deleteUser method
    }
}