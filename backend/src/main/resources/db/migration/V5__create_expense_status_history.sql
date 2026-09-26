-- ---------------------------------------------------------------------
-- Table : expense_status_history
-- ---------------------------------------------------------------------
CREATE TABLE expense_status_history (
                                        id                  BIGSERIAL PRIMARY KEY,
                                        expense_id          BIGINT NOT NULL,
                                        previous_status     VARCHAR(40),
                                        new_status          VARCHAR(40) NOT NULL,
                                        changed_by          BIGINT NOT NULL,
                                        comment             TEXT,
                                        changed_at          TIMESTAMP NOT NULL DEFAULT now(),

                                        CONSTRAINT fk_expense_status_history_expense
                                            FOREIGN KEY (expense_id) REFERENCES expenses (id),
                                        CONSTRAINT fk_expense_status_history_changed_by
                                            FOREIGN KEY (changed_by) REFERENCES users (id)
);

CREATE INDEX idx_expense_status_history_expense_id ON expense_status_history (expense_id);