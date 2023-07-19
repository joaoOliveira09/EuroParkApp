package br.csi.Parkingcontrol.configuracoes.Security;

import java.util.Date;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import br.csi.Parkingcontrol.model.UserModel;

public class JWTAutentication {
    public static final long TOKEN_EXPIRA = Duration.ofMinutes(2000).toMillis();
    public static final String TOKEN_SENHA = "JV123";

    public String geraToken(UserModel usuario) {

        final Map<String, Object> claims = new HashMap<>();
        claims.put("sub", usuario.getUserId());
       // claims.put("permissao", usuario.getPermissao());

        return Jwts.builder()
                .setClaims(claims)
                .setExpiration(new Date(System.currentTimeMillis() + TOKEN_EXPIRA))
                .signWith(SignatureAlgorithm.HS256, TOKEN_SENHA)
                .compact();
    }

    public UUID getSubToken(String token) {
        if (token != null) {
            return UUID.fromString(this.parseToken(token).getSubject());
        } else {
            return null;
        }
    }

    public Boolean isTokenExpirado(String token) {
        return this.parseToken(token).getExpiration().before(new Date());
    }

    private Claims parseToken(String token) {
        return Jwts.parser()
                .setSigningKey(TOKEN_SENHA)
                .parseClaimsJws(token.replace("Bearer", ""))
                .getBody();
    }

}
