# Carregar bibliotecas
library(readxl)
library(openxlsx)

# Ler os dados das tabelas
ds1 <- read_excel("Disciplinas.xlsx")
ds2 <- read_excel("reprovacoes_14_22.xlsx")

# Renomear a coluna COD para Cod
names(ds1)[names(ds1) == "COD"] <- "Cod"

# Mesclar os dados com base na coluna Cod
merged_data <- merge(ds2, ds1[, c("Cod", "Sem")], by.x = "COD_DISCIPLINA", by.y = "Cod", all.x = TRUE)

# Substituir valores NA na coluna "Sem" por "Inativo"
merged_data$Sem[is.na(merged_data$Sem)] <- "Inativo"

# Salvar o resultado em um novo arquivo Excel
write.csv(merged_data, "resultado_final.csv")
