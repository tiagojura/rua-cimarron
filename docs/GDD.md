# Rua Cimarron — Game Design Document

**Versão:** 0.1 (rascunho)
**Data:** 20/11/2026
**Autor:** Tiago (tiagojura)
**Disciplina:** Fundamentos de Sistemas de Informação — UEA
**Obra de inspiração:** *Eu Sou a Lenda*, de Richard Matheson (1954)

---

## 1. Visão geral

| Item | Definição |
|---|---|
| Nome provisório | Rua Cimarron |
| Gênero | Sobrevivência top-down |
| Subgênero | Defesa de base (gerenciamento de recursos + defesa em tempo real) |
| Engine | Godot 4.7.2 (GDScript) |
| Plataforma | Navegador (Web) e desktop (Linux/Windows) |
| Duração de uma partida | ~15 minutos (3 ciclos de dia e noite) |
| Jogadores | 1 |

## 2. Conceito central

> Sobreviva a três noites como Robert Neville, o último homem vivo: use o dia para se preparar e a noite para manter a casa de pé.

## 3. História e contexto

Los Angeles, 1976. Uma pandemia transformou a humanidade em vampiros. Robert Neville é, até onde sabe, o único sobrevivente. Ele vive sozinho numa casa da Rua Cimarron, com as janelas tapadas por tábuas e protegidas por colares de alho. Durante o dia, a cidade é silenciosa e segura. Ao anoitecer, os vampiros cercam a casa, batem nas janelas e chamam seu nome.

O jogo retrata três dias dessa rotina, inspirado na Parte 1 do livro. A inspiração vem exclusivamente da obra literária, não das adaptações para o cinema.

## 4. Objetivo do jogador

Sobreviver a **3 noites** sem que nenhum vampiro invada a casa.

## 5. Loop principal de gameplay

```
☀️ DIA (fora de casa)                     🌙 NOITE (dentro de casa)
Colher alho na estufa                     Vampiros atacam as janelas
Juntar tábuas no entulho  ──anoitece──▶   Correr até a janela mais danificada
Pendurar alho e pregar tábuas             Gastar tábuas para consertar
Voltar antes do anoitecer ◀──amanhece──   Sobreviver até o sol nascer
```

As decisões do jogador vêm da escassez de tempo e de recursos:
- O dia é curto: colher alho ou juntar tábuas?
- As tábuas são limitadas: reforçar agora ou guardar para a noite?
- Duas janelas cedendo ao mesmo tempo: qual salvar?

## 6. Mecânicas fundamentais (MVP)

> Os valores numéricos são **iniciais** e serão ajustados nos testes de balanceamento (03/12).

### 6.1 Movimento e interação
- Movimento em 8 direções (WASD ou setas).
- Tecla **E** interage com o objeto mais próximo (estufa, entulho, janela).

### 6.2 Ciclo de dia e noite
- Dia: **180 segundos**. Noite: **120 segundos**.
- Relógio sempre visível no HUD.
- Aviso visual **30 segundos** antes do anoitecer (céu alaranjado + mensagem).
- **Se o jogador estiver fora de casa quando anoitecer, a partida termina em derrota.** (Referência ao episódio do relógio parado, na Parte 1 do livro.)

### 6.3 Janelas
- A casa tem **4 janelas**.
- Cada janela tem **resistência de 0 a 100**, que começa em 100.
- O dano recebido numa noite **permanece** para o dia seguinte; só tábuas recuperam a resistência.
- Pregar uma tábua: consome 1 tábua e recupera **+25** de resistência (máximo 100).
- **Se qualquer janela chegar a 0, um vampiro entra na casa: derrota.**

### 6.4 Tábuas
- Obtidas na pilha de entulho do quintal (os restos das casas vizinhas que Neville queimou, como no livro).
- O entulho oferece **8 tábuas por dia**, repostas ao amanhecer.
- O jogador carrega no máximo **6 tábuas** de cada vez.

### 6.5 Alho
- Colhido na estufa dos fundos: **4 alhos por dia**, repostos ao amanhecer.
- Pendurar alho numa janela consome 1 alho e deixa o alho daquela janela com **frescor de 100%**.
- O frescor cai **50% a cada ciclo completo** (dia + noite), de forma contínua.
- Efeito: **dano recebido = dano do vampiro × (1 − 0,5 × frescor)**. Ou seja, alho fresco reduz o dano pela metade, e alho velho não protege.
- Referência no livro: Neville troca os colares de alho duas vezes por semana, porque eles perdem o cheiro.

### 6.6 Vampiros
- Surgem nas bordas do mapa ao anoitecer.
- Cada vampiro escolhe uma janela aleatória, caminha até ela e a ataca continuamente.
- Ao amanhecer, os vampiros fogem e desaparecem.

| Noite | Vampiros | Dano por segundo (cada) |
|---|---|---|
| 1 | 2 | 1,0 |
| 2 | 3 | 1,25 |
| 3 | 4 | 1,5 |

### 6.7 Diário de Neville
- A cada amanhecer, uma tela mostra uma frase curta do diário de Neville sobre a noite anterior.
- Os textos são escritos pelo autor do jogo, inspirados no tom do livro (sem reproduzir trechos da obra).

## 7. Sistemas secundários (fila de extras, por prioridade)

Entram somente depois do MVP pronto, na ordem abaixo, enquanto houver tempo:

1. Caça com estacas a vampiros adormecidos durante o dia (estacas são finitas)
2. Áudio ambiente e efeitos sonoros
3. Vida e fome
4. Mapa maior, com casas para vasculhar
5. Ben Cortman como inimigo recorrente
6. Sanidade, dias nublados que escondem o relógio, fragmentos do diário, evento do cão

## 8. Direção artística

- **Estilo:** pixel art, visão de cima (top-down).
- **Casa em corte:** a casa aparece sem telhado, para que o interior fique visível à noite.
- **Paleta:** dessaturada; de dia, tons de ocre, cinza e verde apagado. À noite, azul escuro, com luz quente vinda do interior da casa (iluminação 2D do Godot).
- **Tamanho dos tiles:** a definir em 21/11 (16 ou 32 pixels), conforme os assets escolhidos.
- **Origem dos assets:** exclusivamente itch.io ou desenhados pelo autor, com licença verificada. Preferência por um pacote-base de um único autor, para manter a consistência visual.

## 9. Interface

**HUD (durante o jogo):**
- Dia atual e relógio
- Contadores de tábuas e alho
- Barra de resistência sobre cada janela
- Indicador de frescor do alho em cada janela

**Telas:**
- Menu inicial: Jogar, Sair
- Pausa (Esc): Continuar, Voltar ao menu
- Diário ao amanhecer
- Derrota: motivo da derrota + Tentar novamente
- Vitória

## 10. Controles

| Ação | Tecla |
|---|---|
| Mover | WASD ou setas |
| Interagir | E |
| Pausar | Esc |

## 11. Progressão

A dificuldade cresce a cada noite (mais vampiros, mais dano), enquanto os recursos diários continuam os mesmos. A pressão aumenta, e o jogador precisa planejar melhor cada dia.

## 12. Condições de vitória e derrota

| Resultado | Condição |
|---|---|
| Vitória | Sobreviver ao fim da 3ª noite |
| Derrota | Uma janela chega a 0 de resistência |
| Derrota | Estar fora de casa quando anoitece |

## 13. Escopo

### MVP (compromisso, pronto até 29/11)
Itens 6.1 a 6.7, mapa de uma tela (casa, quintal, estufa e entulho), menus e telas da seção 9.

### Extras
Seção 7, em ordem de prioridade.

### Fora do escopo
Crafting complexo, vários mapas, salvar/carregar, diálogos ramificados.

## 14. Relação entre as mecânicas e o livro

| Mecânica | Elemento do livro |
|---|---|
| Ciclo dia/noite | De dia Neville sai em segurança; à noite os vampiros cercam a casa |
| Derrota fora de casa ao anoitecer | O relógio parado, que o deixa longe de casa ao entardecer |
| Janelas com tábuas | As tábuas arrancadas nos ataques, que Neville precisa repregar |
| Alho que perde o frescor | Os colares de alho trocados duas vezes por semana |
| Estufa | A estufa onde Neville cultiva alho |
| Entulho como fonte de tábuas | As casas vizinhas queimadas por Neville |
| Diário ao amanhecer | A solidão e a introspecção do protagonista |

## 15. Histórico de versões

| Versão | Data | Alteração |
|---|---|---|
| 0.1 | 20/11/2026 | Primeiro rascunho |
