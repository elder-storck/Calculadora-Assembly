# Calculadora em Assembly x86

Este é um programa em Assembly x86 que implementa uma calculadora simples de linha de comando, capaz de realizar operações básicas de adição, subtração, multiplicação e divisão.

## Funcionalidades

- Realiza operações matemáticas básicas: +, -, *, /
- Suporta números positivos e negativos
- Exibe o resultado após cada cálculo
- Interface simples de linha de comando

## Como usar

1. Execute o programa em um ambiente que suporte executáveis DOS/Assembly x86
2. Digite uma expressão matemática simples (ex: "5+3" ou "10*-2")
3. Pressione Enter para ver o resultado
4. Para sair do programa, digite 's' e pressione Enter

## Formato de entrada

- Operações suportadas: `+`, `-`, `*`, `/`
- Números podem ser positivos ou negativos
- Exemplos válidos:
  - 5+3
  - -10*4
  - 25/-5

## Estrutura do código

O programa está organizado nas seguintes seções principais:

1. **Inicialização**: Configuração dos registradores e segmentos
2. **Loop principal**: 
   - Leitura da entrada do usuário
   - Processamento do comando (incluindo saída se 's' for digitado)
   - Processamento da expressão matemática
3. **Subrotinas**:
   - `processar_expressao`: Extrai os números e o operador
   - `encontrar_operador`: Localiza o operador na string
   - `processar_numero`: Converte string para número
   - `calculate`: Executa a operação matemática
   - `print`: Exibe o resultado
   - `bin2ascii`: Converte o resultado numérico para string ASCII

## Requisitos

- Ambiente que execute programas DOS (como DOSBox ou emulador similar)
- Montador Assembly x86 (como NASM) para modificar o código

## Limitações

- Suporta apenas operações com dois operandos
- Não verifica overflow matemático
- A entrada está limitada a um buffer fixo de tamanho

## Exemplo de uso

```
Digite expressão (ex: 5+3): 10*5
00050
Digite expressão (ex: 5+3): -8/2
-0040
Digite expressão (ex: 5+3): s
(programa encerra)
```
