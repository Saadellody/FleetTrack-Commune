-- ---------------------------------------------------------------------
-- Table : audit_logs
-- ---------------------------------------------------------------------
CREATE TABLE audit_logs (
                            id              BIGSERIAL PRIMARY KEY,
                            user_id         BIGINT,
                            action          VARCHAR(50),
                            entity_type     VARCHAR(50),
                            entity_id       BIGINT NOT NULL,
                            old_value       JSONB,
                            new_value       JSONB,
                            ip_address      VARCHAR(45),
                            created_at      TIMESTAMP NOT NULL DEFAULT now(),

                            CONSTRAINT fk_audit_logs_user
                                FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE INDEX idx_audit_logs_entity ON audit_logs (entity_type, entity_id);
CREATE INDEX idx_audit_logs_user_id ON audit_logs (user_id);
