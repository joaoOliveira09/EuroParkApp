package br.csi.Parkingcontrol.service;

import java.time.temporal.Temporal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.concurrent.TimeUnit;

import javax.transaction.Transactional;

import br.csi.Parkingcontrol.model.VagaModel;
import org.springframework.stereotype.Service;

import br.csi.Parkingcontrol.model.ReservaModel;
import br.csi.Parkingcontrol.repository.ReservaRepository;

@Service
public class ReservaService {

    private ReservaRepository reservaRepository;

    public ReservaService(ReservaRepository reservaRepository) {
        this.reservaRepository = reservaRepository;
    }

    @Transactional
    public ReservaModel save(ReservaModel reservaModel) {
            return reservaRepository.save(reservaModel);

    }

    public ArrayList<ReservaModel> findAll() {
        return (ArrayList<ReservaModel>) reservaRepository.findAll();
    }

    public Optional<ReservaModel> findById(UUID id) {
        return reservaRepository.findById(id);
    }

    public void delete(UUID id) {
        System.out.println(id);
        reservaRepository.deleteById(id);
    }

    public ReservaModel update(UUID id, ReservaModel reservaModel) {
        ReservaModel reservaModel2 = reservaRepository.getReferenceById(id);

        reservaModel2.setPeriodo(reservaModel.getPeriodo());
        reservaModel2.setVaga(reservaModel.getVaga());

        reservaRepository.flush();
        return reservaModel2;
    }


}
