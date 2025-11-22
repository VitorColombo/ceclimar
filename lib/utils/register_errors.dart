enum RegisterError {
  requiredField('Campo obrigatório'),
  invalidCharacter('Caractere inválido'),
  minimumCharacter('Caracteres mínimos: '),
  maximumCharacter('Caracteres máximos: '),
  imageError('É obrigatório o envio de uma foto'),
  onlyNumber('Apenas n°'),
  switchError('É necessario preencher no mínimo um dos campos abaixo');

   final String message;
   const RegisterError(this.message);
}