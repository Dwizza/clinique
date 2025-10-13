package com.cliniquedigitale.mapper;

import com.cliniquedigitale.DTO.Request.RequestPatientDTO;
import com.cliniquedigitale.DTO.Response.ResponsePatientDTO;
import com.cliniquedigitale.DTO.Response.ResponseUserDTO;
import com.cliniquedigitale.entities.Patient;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class PatientMapper {

    public static Patient toEntity(RequestPatientDTO dto){
        if(dto == null){
            return null;
        }
        Patient patient = new Patient();
        patient.setCin(dto.getCin());
        patient.setNaissance(dto.getNaissance());
        patient.setSexe(dto.getSexe());
        patient.setAdresse(dto.getAdresse());
        patient.setTelephone(dto.getTelephone());
        patient.setSang(dto.getSang());
        return patient;
    }

    public static ResponsePatientDTO toResponse(Patient patientEntity){
        ResponsePatientDTO response = new ResponsePatientDTO();
        response.setCin(patientEntity.getCin());
        response.setNaissance(patientEntity.getNaissance());
        response.setSexe(patientEntity.getSexe());
        response.setAdresse(patientEntity.getAdresse());
        response.setTelephone(patientEntity.getTelephone());
        response.setSang(patientEntity.getSang());
        return response;
    }


}
