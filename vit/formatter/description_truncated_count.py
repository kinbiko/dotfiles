from vit.formatter.description_count import DescriptionCount
from vit.util import unicode_len

TRUNCATE_LEN = 70

class DescriptionTruncatedCount(DescriptionCount):
    def format(self, description, task):
        if not description:
            return self.empty()
        truncated_description = description[:TRUNCATE_LEN] + '...' if unicode_len(description) > TRUNCATE_LEN else description
        width = unicode_len(truncated_description)
        colorized_description = self.colorize_description(truncated_description)
        if not task['annotations']:
            return (width, colorized_description)
        else:
            count_width, colorized_description = self.format_count(colorized_description, task)
            return (width + count_width, colorized_description)
