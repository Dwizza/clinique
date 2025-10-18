package com.cliniquedigitale.controllers.admin;

import com.cliniquedigitale.DTO.DepartmentDTO;
import com.cliniquedigitale.DTO.DoctorDTO;
import com.cliniquedigitale.DTO.Request.RequestPatientDTO;
import com.cliniquedigitale.DTO.Request.RequestUserDTO;
import com.cliniquedigitale.DTO.Response.ResponseUserDTO;
import com.cliniquedigitale.Enums.Role;
import com.cliniquedigitale.entities.Patient;
import com.cliniquedigitale.entities.Specialty;
import com.cliniquedigitale.entities.User;
import com.cliniquedigitale.service.*;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    @Inject
    private DepartmentService departmentService;

    @Inject
    private PatientService patientService;

    @Inject
    private SpecialtyService specialtyService;

    @Inject
    private AuthService authService;

    @Inject
    private StaffService staffService;

    @Inject
    private DoctorSevice doctorSevice;

    @Inject
    private UserService userService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ResponseUserDTO user = (ResponseUserDTO) request.getSession().getAttribute("user");
        System.out.println("user: "+ user);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String path = request.getPathInfo();
        if (path != null && path.equals("/users/toggle")) {
            handleToggleUserStatus(request, response);
            return;
        }

        List<User> allUsers = userService.getAllUsers();
        List<User> doctors = userService.getUsersByRole(Role.DOCTOR);
        List<User> staffMembers = userService.getUsersByRole(Role.STAFF);
        List<User> patients = userService.getUsersByRole(Role.PATIENT);

        request.setAttribute("allUsers", allUsers);
        request.setAttribute("doctors", doctors);
        request.setAttribute("staffMembers", staffMembers);
        request.setAttribute("patients", patients);

        request.setAttribute("totalUsers", allUsers.size());
        request.setAttribute("totalDoctors", doctors.size());
        request.setAttribute("totalStaff", staffMembers.size());
        request.setAttribute("totalPatients", patients.size());
        request.setAttribute("activeUsers", userService.countActiveUsers());

        List<DepartmentDTO> departments = departmentService.getAll();
        request.setAttribute("departments", departments);

        List<Specialty> specialities = specialtyService.getAll();
        request.setAttribute("specialities", specialities);

        request.getRequestDispatcher("/WEB-INF/view/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String path = request.getPathInfo();
        if (path == null || path.isEmpty() || "/".equals(path)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        if ("/users/create".equals(path)) {
            handleCreateUsers(request, response);
        } else if ("/users/toggle".equals(path)) {
            handleToggleUserStatus(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleToggleUserStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String userIdStr = request.getParameter("userId");
            if (userIdStr == null || userIdStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin?error=invalidUserId");
                return;
            }

            UUID userId = UUID.fromString(userIdStr);
            userService.toggleUserStatus(userId);

            response.sendRedirect(request.getContextPath() + "/admin?success=statusUpdated");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin?error=updateFailed");
        }
    }

    private void handleCreateUsers(HttpServletRequest request, HttpServletResponse response) throws IOException {
        ResponseUserDTO sessionUser = (ResponseUserDTO) request.getSession().getAttribute("user");
        if (sessionUser == null || sessionUser.getRole() == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String role = request.getParameter("role");
        if ("PATIENT".equals(role)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            String cin = request.getParameter("cin");
            String naissanceStr = request.getParameter("naissance");
            String sexe = request.getParameter("sexe");
            String adresse = request.getParameter("adresse");
            String telephone = request.getParameter("telephone");
            String sang = request.getParameter("sang");

            if (isInvalid(name, email, password, confirmPassword, cin, naissanceStr, sexe, telephone)) {
                response.sendRedirect(request.getContextPath() + "/admin?error=validation");
                return;
            }

            LocalDate naissance;
            try {
                naissance = LocalDate.parse(naissanceStr);
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/admin?error=invaliddate");
                return;
            }

            RequestUserDTO userDTO = new RequestUserDTO();
            userDTO.setName(name);
            userDTO.setEmail(email);
            userDTO.setPassword(password);
            userDTO.setRole(Role.PATIENT);
            userDTO.setActif(true);

            RequestPatientDTO patientDTO = new RequestPatientDTO();
            patientDTO.setCin(cin);
            patientDTO.setNaissance(naissance);
            patientDTO.setSexe(sexe);
            patientDTO.setAdresse(adresse);
            patientDTO.setTelephone(telephone);
            patientDTO.setSang(sang);

            try {
                authService.registerPatient(userDTO, patientDTO);
                response.sendRedirect(request.getContextPath() + "/admin?created=patient");
            } catch (IllegalArgumentException ex) {
                response.sendRedirect(request.getContextPath() + "/admin?error=" + encodeForQuery(ex.getMessage()));
            }

        } else if ("STAFF".equals(role)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirmPassword");

            RequestUserDTO userDTO = new RequestUserDTO();
            userDTO.setName(name);
            userDTO.setEmail(email);
            userDTO.setPassword(password);
            userDTO.setRole(Role.STAFF);
            userDTO.setActif(true);

            try {
                staffService.registerStaff(userDTO);
                response.sendRedirect(request.getContextPath() + "/admin?created=staff");
            } catch (IllegalArgumentException ex) {
                response.sendRedirect(request.getContextPath() + "/admin?error=" + encodeForQuery(ex.getMessage()));
            }



        } else if ("DOCTOR".equals(role)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirmPassword");

            if (!password.equals(confirm)){

            }

            String matricule = request.getParameter("matricule");
            String titre = request.getParameter("titre");
            UUID specialityId = UUID.fromString(request.getParameter("specialityId"));

            RequestUserDTO userDTO = new RequestUserDTO();
            userDTO.setName(name);
            userDTO.setEmail(email);
            userDTO.setPassword(password);
            userDTO.setRole(Role.DOCTOR);
            userDTO.setActif(true);

            DoctorDTO doctorDTO = new DoctorDTO();
            doctorDTO.setMatricule(matricule);
            doctorDTO.setTitre(titre);
            doctorDTO.setSpecialtyId(specialityId);

            try {
                doctorSevice.registerDoctor(userDTO, doctorDTO);
                response.sendRedirect(request.getContextPath() + "/admin?created=doctor");
            } catch (IllegalArgumentException ex) {
                response.sendRedirect(request.getContextPath() + "/admin?error=" + encodeForQuery(ex.getMessage()));
            }
        }else {
            response.sendRedirect(request.getContextPath() + "/admin?error=unsupportedRole");
            return;
        }


    }

    private boolean isInvalid(String name, String email, String password, String confirmPassword,
                              String cin, String naissance, String sexe, String telephone) {
        return name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.length() < 6
                || !password.equals(confirmPassword)
                || cin == null || cin.trim().isEmpty()
                || naissance == null || naissance.trim().isEmpty()
                || sexe == null || sexe.trim().isEmpty()
                || telephone == null || telephone.trim().isEmpty();
    }

    private String encodeForQuery(String s) {
        if (s == null) return "";
        return s.replace(" ", "+");
    }
}
