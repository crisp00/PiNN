void setup(){
    NeuralNetwork nn = new NeuralNetwork(new int[]{3, 1}, 2);
    double[] output = nn.compute(new double[]{1, 1});
    for(int i = 0; i < output.length; i++){
      println(i + ": " + output[i]); 
    }
    nn.backpropagate(new double[]{1, 1}, new double[]{0});
}

void draw(){
  
}

class NeuralNetwork{
  Layer[] l;
  
  public NeuralNetwork(int layerSizes[], int inputSize){
    l = new Layer[layerSizes.length];
    l[0] = new Layer(layerSizes[0], inputSize);
    for(int i = 1; i < layerSizes.length; i++){
      l[1] = new Layer(layerSizes[i], l[i - 1]);
    }
  }
  
  double[] compute(double[] input){
    double[] lastActivations;
    lastActivations = l[0].fire(input);
    for(int i = 1; i < l.length; i++){
      lastActivations = l[i].fire(lastActivations);  
    }
    return lastActivations;
  }
  
  void backpropagate(double[] input, double[] expOutput){
    double[] output = compute(input);
    float firstCost = cost(output, expOutput);
    double[] _output = output;
    _output[0] += 0.1;
    double pdCostOutput = cost(_output, expOutput);
    double[] in = l[1].n[0].input;
    _output[0] = l[1].n[0].compute();
    double pdCostWeight = l[1].n[0].
    
    l[0].n[0].weights[0] += 0.1;
    output = compute(input);
    float lastCost = cost(output, expOutput);
    println(firstCost + " " + lastCost);
  }
  
  float cost(double[] output, double[] expOutput){
    float cost = 0;
    for(int i = 0; i < output.length; i++){
      cost += abs((float)(output[i] - expOutput[i]));
    }
    return cost;
  }
  
}

class Layer{
  int size;
  Layer prevLayer;
  Neuron[] n;
  double[] activations;
  
  public Layer(int size, Layer prevLayer){
    this.size = size;
    this.prevLayer = prevLayer;
    n = new Neuron[size];
    for(int i = 0; i < size; i++){
      n[i] = new Neuron(prevLayer.size);
    }
    activations = new double[size];
  }
  
  public Layer(int size, int inputSize){
    this.size = size;
    n = new Neuron[size];
    for(int i = 0; i < size; i++){
      n[i] = new Neuron(inputSize);
    }
    activations = new double[size];
  }
  
  double[] fire(double[] activations){
    for(int i = 0; i < n.length; i++){
      this.activations[i] = n[i].compute(activations);
    }
    return this.activations;
  }
  
}

class Neuron{
  int synapses;
  double[] weights;
  double bias = 0;
  double[] input;
  double weightedInput;
  
  public Neuron(int synapses){
    this.synapses = synapses;
    weights = new double[synapses];
    for(int i = 0; i < weights.length; i++){
      weights[i] = random(-1, 1);
    }
  }
  
  public Neuron(double[] weights, double bias){
    synapses = weights.length;
    this.weights = weights;
    this.bias = bias;
  }
  
  public double compute(double[] input){
    this.input = input;
    double[] weightedInputs = vectorMultiply(input, weights);
    for(int i = 0; i < weightedInputs.length; i++){
      weightedInputs[i] += bias;
    }
    weightedInput = vectorSum(weightedInputs);
    return sigmoid(weightedInput);
  }
}

double[] vectorMultiply(double[] a, double[] b){
  double[] a_ = a;
  for(int i = 0; i < a_.length && i < b.length; i++){
      a_[i] *= b[i];
  }
  return a_;
}

double vectorSum(double[] a){
  double sum = 0;
  for(int i = 0; i < a.length; i++){
    sum += a[i];
  }
  return sum;
}

double sigmoid(double x){
  return 1 / (1 + Math.exp(-x));
}