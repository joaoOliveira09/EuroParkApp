package br.csi.Parkingcontrol.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.csi.Parkingcontrol.model.ReservaModel;
import br.csi.Parkingcontrol.model.VagaModel;
import br.csi.Parkingcontrol.repository.ReservaRepository;

import br.csi.Parkingcontrol.service.ReservaService;

@RestController
// @CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/reserva")

public class ReservaController {


    private ReservaService reservaService;
    private ReservaRepository reservaRepository;

    public ReservaController(ReservaService reservaService) {
        this.reservaService = reservaService;
    }

    @PostMapping
    public ReservaModel saveReserva(@RequestBody ReservaModel reservaModel) {
        System.out.println(reservaModel);
        // Aqui possivelmente entrarão Regras de negocios
        return reservaService.save(reservaModel);
    }

    @GetMapping()
    public ArrayList<ReservaModel> getReservas() {
        return this.reservaService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Object> getOneReserva(@PathVariable(value = "id") UUID id) {
        Optional<ReservaModel> parkingSpotModelOptional = reservaService.findById(id);
        if (!parkingSpotModelOptional.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Reserva não encontrada");
        }
        return ResponseEntity.status(HttpStatus.OK).body(parkingSpotModelOptional.get());
    }

    @DeleteMapping("/{id}")
    public void deleteReserva(@PathVariable(value = "id") UUID id) {
        System.out.println(id);
        ArrayList<ReservaModel> lista = new ArrayList<>();

        reservaService.delete(id);


        
    }

    @PatchMapping("{id}")
    public ResponseEntity<Object> updateReserva(@PathVariable(value = "id") UUID id,
            @RequestBody ReservaModel reservaModel) {

        ReservaModel reservaModel2 = reservaService.update(id, reservaModel);
        //System.out.println(reservaModel2);

        return new ResponseEntity<>(reservaModel2.toString(), HttpStatus.OK);
    }



}
