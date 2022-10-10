import sys


before_str = """
        safety_checker_input = self.feature_extractor(self.numpy_to_pil(image), return_tensors="pt").to(self.device)
        image, has_nsfw_concept = self.safety_checker(
            images=image, clip_input=safety_checker_input.pixel_values.to(text_embeddings.dtype)
        )
"""

after_str = """
        has_nsfw_concept = [False]
"""


if __name__ == '__main__':

    with open(sys.argv[1],'r') as f:    
        inpt = f.read()
    oupt = inpt.replace(before_str, after_str)

    with open(sys.argv[1],'w') as f:    
        f.write(oupt)