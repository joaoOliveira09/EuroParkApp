package br.csi.Parkingcontrol.service;

import java.util.ArrayList;
import java.util.Optional;
import java.util.UUID;

// import java.time.LocalDateTime;
// import java.time.format.DateTimeFormatter;

import javax.transaction.Transactional;

import br.csi.Parkingcontrol.model.UserModel;
import org.springframework.stereotype.Service;

import br.csi.Parkingcontrol.model.VagaModel;
import br.csi.Parkingcontrol.repository.VagaRepository;

@Service
public class VagaService {
    private VagaRepository vagaRepository;

    public VagaService(VagaRepository vagaRepository) {
        this.vagaRepository = vagaRepository;
    }

    @Transactional
    public VagaModel save(VagaModel vagaModel) {
        System.out.println(vagaModel);
        return vagaRepository.save(vagaModel);
    }

    public ArrayList<VagaModel> findAll() {
        return (ArrayList<VagaModel>) vagaRepository.findAll();
    }

    public VagaModel findById(UUID id) {
        VagaModel vaga = new VagaModel();
        vaga = this.vagaRepository.findById(id).get();
        return vaga;
    }


    public void delete(UUID id) {
        vagaRepository.deleteById(id);
    }


}
