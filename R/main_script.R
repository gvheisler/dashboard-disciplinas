library(readxl)
library(dplyr)

arquivos <- list.files(path = "relatorios", pattern = "\\.xlsx$", full.names = TRUE)

ler_e_remover <- function(arquivo) {
  dados <- read_excel(arquivo)
  if ("COD_CURSO" %in% colnames(dados) && "NOME_CURSO" %in% colnames(dados)) {
    dados <- select(dados, -c(COD_CURSO, NOME_CURSO))
  }
  return(dados)
}

dados_totais <- lapply(arquivos, ler_e_remover)
dados_totais <- bind_rows(dados_totais)

disciplinas <- read_excel("Disciplinas_curriculo2024.xlsx")

names(disciplinas)[names(disciplinas) == "COD"] <- "Cod"

merged_data <- merge(dados_totais, disciplinas[, c("Cod", "Sem")], by.x = "COD_DISCIPLINA", by.y = "Cod", all.x = TRUE)

merged_data$Sem[is.na(merged_data$Sem)] <- "Inativo"

write.csv(merged_data, "disciplinas_completo.csv")
