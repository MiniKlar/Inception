# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: GitHub Copilot <copilot@42.fr>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/12/01 12:00:00 by copilot           #+#    #+#              #
#    Updated: 2025/12/01 12:00:00 by copilot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# --- Configuration ---
NAME		= inception
SRCS_DIR	= ./srcs
COMPOSE		= docker compose -f $(SRCS_DIR)/docker-compose.yml
ENV_FILE	= $(SRCS_DIR)/.env
DATA_DIR	= /home/lomont/data

# --- Colors & Visuals ---
RESET		= \033[0m
BOLD		= \033[1m
RED			= \033[31m
GREEN		= \033[32m
YELLOW		= \033[33m
BLUE		= \033[34m
CYAN		= \033[36m
MAGENTA		= \033[35m

# --- Loading Bar Function ---
define loading_bar
	@echo -n "$(CYAN)$(BOLD)[Loading] $(RESET)"
	@for i in {1..20}; do \
		echo -n "▓"; \
		sleep 0.05; \
	done
	@echo "$(GREEN)$(BOLD) [OK]$(RESET)"
endef

# --- Rules ---

all: up

# ------------------------------------------------------------------------------
# MANDATORY PART
# ------------------------------------------------------------------------------
up: setup_dirs set_bonus_false
	@echo "\n$(BLUE)$(BOLD)🚀 Starting Inception (Mandatory Mode)...$(RESET)"
	$(call loading_bar)
	@$(COMPOSE) up -d --remove-orphans
	@echo "$(GREEN)✅ Inception is up and running!$(RESET)"
	@echo "$(CYAN)🌐 URL: https://lomont.42.fr$(RESET)"

# ------------------------------------------------------------------------------
# BONUS PART
# ------------------------------------------------------------------------------
bonus: setup_dirs set_bonus_true
	@echo "\n$(MAGENTA)$(BOLD)🚀 Starting Inception (Bonus Mode)...$(RESET)"
	$(call loading_bar)
	@$(COMPOSE) --profile bonus up -d --remove-orphans
	@echo "$(GREEN)✅ Inception (Bonus) is up and running!$(RESET)"
	@echo "$(CYAN)🌐 Website: https://lomont.42.fr$(RESET)"
	@echo "$(CYAN)📊 Adminer: http://lomont.42.fr/8080"
	@echo "$(CYAN)🐳 Portainer: http://lomont.42.fr:9001$(RESET)"
	@echo "$(CYAN)🌐 Static Site: https://lomont.42.fr/website$(RESET)"

# ------------------------------------------------------------------------------
# UTILS & CONFIG
# ------------------------------------------------------------------------------

# Modifie le .env pour mettre BONUS="false"
set_bonus_false:
	@echo "$(YELLOW)🔧 Configuring environment for MANDATORY...$(RESET)"
	@sed -i 's/^BONUS=.*/BONUS="false"/' $(ENV_FILE)

# Modifie le .env pour mettre BONUS="true"
set_bonus_true:
	@echo "$(YELLOW)🔧 Configuring environment for BONUS...$(RESET)"
	@sed -i 's/^BONUS=.*/BONUS="true"/' $(ENV_FILE)

# Crée les dossiers de données s'ils n'existent pas
setup_dirs:
	@mkdir -p $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/mariadb

# ------------------------------------------------------------------------------
# CLEANING
# ------------------------------------------------------------------------------
down:
	@echo "\n$(YELLOW)🛑 Stopping containers...$(RESET)"
	@$(COMPOSE) --profile bonus down
	@echo "$(GREEN)✅ Containers stopped.$(RESET)"

clean: down
	@echo "$(YELLOW)🧹 Cleaning unused objects...$(RESET)"
	@docker system prune -af
	@echo "$(GREEN)✅ Clean complete.$(RESET)"

fclean: down
	@echo "\n$(RED)$(BOLD)💥 Destroying everything (Images, Volumes, Networks)...$(RESET)"
	$(call loading_bar)
	@$(COMPOSE) down -v --rmi all --remove-orphans
	@docker system prune -af --volumes
	@echo "$(RED)🗑️  Deleting data directories...$(RESET)"
	@sudo rm -rf $(DATA_DIR)/*
	@echo "$(GREEN)✅ System reset to zero.$(RESET)"

re: fclean all

# ------------------------------------------------------------------------------
# DEBUG & LOGS
# ------------------------------------------------------------------------------
logs:
	@$(COMPOSE) logs -f

status:
	@echo "\n$(CYAN)$(BOLD)📊 Container Status:$(RESET)"
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

.PHONY: all up bonus down clean fclean re logs status setup_dirs set_bonus_false set_bonus_true
