package br.csi.Parkingcontrol.configuracoes.Security;

import java.util.Arrays;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    private final UserDatailsServiceImpl userDetail;

    @Bean
    @Override
    protected AuthenticationManager authenticationManager() throws Exception {
        return super.authenticationManager();
    }

    @Bean
    public JWTFilter jwtFilter() {
        return new JWTFilter();
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    public WebSecurityConfig(UserDatailsServiceImpl userDetail) {
        this.userDetail = userDetail;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetail).passwordEncoder(passwordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable().authorizeHttpRequests()
                .antMatchers(HttpMethod.POST, "/login").permitAll()

                .antMatchers(HttpMethod.GET, "/user").permitAll()
                .antMatchers(HttpMethod.GET, "/user/{id}").permitAll()
                .antMatchers(HttpMethod.POST, "/user").permitAll()
                .antMatchers(HttpMethod.PUT, "/user/{id}").permitAll()
                .antMatchers(HttpMethod.PATCH, "/user/{id}").permitAll()
                .antMatchers(HttpMethod.DELETE, "/user/{id}").permitAll()

                .antMatchers(HttpMethod.GET, "/parking-spot").permitAll()
                .antMatchers(HttpMethod.GET, "/parking-spot/{id}").permitAll()
                .antMatchers(HttpMethod.POST, "/parking-spot").permitAll()
                .antMatchers(HttpMethod.PATCH, "/parking-spot/{id}").permitAll()
                .antMatchers(HttpMethod.DELETE, "/parking-spot/{id}").permitAll()

                .antMatchers(HttpMethod.GET, "/reserva").permitAll()
                .antMatchers(HttpMethod.GET, "/reserva/{id}").permitAll()
                .antMatchers(HttpMethod.POST, "/reserva").permitAll()
                .antMatchers(HttpMethod.PATCH, "/reserva/{id}").permitAll()
                .antMatchers(HttpMethod.DELETE, "/reserva/{id}").permitAll()

                .antMatchers(HttpMethod.GET, "/minhaReserva/{id}").permitAll()
                .anyRequest().authenticated()
                .and()
                .cors()
                .and()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);

        http.addFilterBefore(this.jwtFilter(), UsernamePasswordAuthenticationFilter.class);
    }

    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        final UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();

        CorsConfiguration corsConfiguration = new CorsConfiguration().applyPermitDefaultValues();
        corsConfiguration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "PATCH", "DELETE"));
        source.registerCorsConfiguration("/**", corsConfiguration);

        return source;
    }
}
// hasAnyAuthority("ADMIN","USER")
